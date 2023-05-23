<header id="headerMobile" class="header-area header-mobile d-lg-none d-xl-none">
{{--    <div class="header-mini bg-top-bar">--}}
{{--        <div class="container">--}}
{{--            <div class="row align-items-center">--}}
{{--                <div class="col-12">--}}

{{--                    <nav id="navbar_0" class="navbar navbar-expand-md navbar-dark navbar-0">--}}
{{--                        <div class="navbar-lang">--}}

{{--                            @if(count($languages) > 1)--}}

{{--                                <div class="select-control">--}}
{{--                                    <select class="form-control" onchange="myFunction1(this.options[this.selectedIndex].value)" >--}}
{{--                                        @foreach($languages as $language)--}}
{{--                                            <option value="{{$language->languages_id}}" @if(Session::get('language_id')==$language->languages_id) selected @endif>{{$language->name}}</option>--}}
{{--                                        @endforeach--}}
{{--                                    </select>--}}
{{--                                </div>d--}}
{{--                                @include('web.common.scripts.changeLanguage')--}}
{{--                            @endif--}}

{{--                            @if(count($currencies) > 1)--}}
{{--                                <div class="select-control currency" >--}}
{{--                                    <select class="form-control " onchange="myFunction2(this.options[this.selectedIndex].value)">--}}
{{--                                        @foreach($currencies as $currency)--}}
{{--                                            <option @if(session('currency_title')==$currency->code) selected @endif value="{{$currency->id}}">--}}

{{--                                                {{$currency->code}}--}}
{{--                                                @if($currency->symbol_left != null)--}}
{{--                                                    ({{$currency->symbol_left}})</span>--}}
{{--                                                @else--}}
{{--                                                ({{$currency->symbol_right}})--}}
{{--                                                @endif--}}

{{--                                            </option>--}}
{{--                                        @endforeach--}}
{{--                                    </select>--}}
{{--                                </div>--}}
{{--                        @endif--}}
{{--                        <!-- END  Currency LANGUAGE CODE SECTION -->--}}
{{--                    </nav>--}}
{{--                </div>--}}
{{--            </div>--}}
{{--        </div>--}}
{{--    </div>--}}
    <div class="header-maxi bg-header-bar" style="background-color: #c70a0a;">
        <div class="container">

            <div class="row align-items-center">
                <div class="col-2 pr-0">
                    <div class="navigation-mobile-container">
                        <a href="javascript:void(0)" class="navigation-mobile-toggler">
                            <span class="fas fa-bars"></span>
                        </a>
                        <nav id="navigation-mobile">
                            <div class="logout-main">
                                <div class="welcome">
                                    <span><?php if(auth()->guard('customer')->check()){ ?>@lang('website.Welcome') {{auth()->guard('customer')->user()->first_name}}&nbsp;! <?php }?> </span>
                                </div>
                                @if(auth()->guard('customer')->check())
                                    <div class="logout">
                                        <a href="{{url('logout')}}" class="">@lang('website.Logout')</a>
                                    </div>
                                @endif
                            </div>
                            @php
                                $category = DB::table('categories')
                                ->join('categories_description', 'categories.categories_id', '=', 'categories_description.categories_id')
                                ->where('categories.parent_id',0)
                                ->where('categories_description.language_id',1)
                                ->select('categories.*','categories_description.categories_name as categories_name')
                                ->get();
                            //dd($category);
                            @endphp
                            <a class="main-manu btn btn-primary" data-toggle="collapse" href="#category" role="button" aria-expanded="false" aria-controls="shoppages1">
                                Category<span><i class="fas fa-chevron-down"></i></span>
                                <span><i class="fas fa-chevron-up"></i></span></a>

                            <div class="sub-manu multi-collapse collapse" id="category" style="">
                                <ul class="unorder-list">
                                    @foreach($category as $cat)
                                        <li class="ml-2">
                                            <div class="dropdown-submenu submenu1"><a class="main-manu btn btn-primary" style="font-size: 13px;" href="https://knoprotec.com/shop?category={{$cat->categories_slug}}">
                                                    {{$cat->categories_name}}</a>
                                            </div>
                                        </li>
                                    @endforeach
                                </ul>
                            </div>


                            {!! $result['commonContent']["menusRecursiveMobile"] !!}

                            <?php if(auth()->guard('customer')->check()){ ?>
                            <a href="{{url('profile')}}" class="main-manu btn btn-primary">@lang('website.Profile')</a>
                            <a href="{{url('wishlist')}}" class="main-manu btn btn-primary">@lang('website.Wishlist')<span class="total_wishlist"> ({{$result['commonContent']['total_wishlist']}})</span></a>
                            <a href="{{url('compare')}}" class="main-manu btn btn-primary">@lang('website.Compare')&nbsp;(<span id="compare">{{$count}}</span>)</a>
                            <a href="{{url('orders')}}" class="main-manu btn btn-primary">@lang('website.Orders')</a>
                            <a href="{{url('shipping-address')}}" class="main-manu btn btn-primary">@lang('website.Shipping Address')</a>
                            <a href="{{url('logout')}}" class="main-manu btn btn-primary">@lang('website.Logout')</a>
                            <?php }else{ ?>
                            <div class="nav-link">@lang('website.Welcome')!</div>
                            <a href="{{ URL::to('/login')}}" class="main-manu btn btn-primary"><i class="fa fa-lock" aria-hidden="true"></i>&nbsp;@lang('website.Login/Register')</a>
                            <?php } ?>
                        </nav>
                    </div>
                </div>



                <div class="col-8">
                    <a href="{{ URL::to('/')}}" class="logo">
                        @if($result['commonContent']['settings']['sitename_logo']=='name')
                            <?=stripslashes($result['commonContent']['settings']['website_name'])?>
                        @endif

                        @if($result['commonContent']['settings']['sitename_logo']=='logo')
                            <img class="img-fluid" src="{{asset('').$result['commonContent']['settings']['website_logo']}}" alt="<?=stripslashes($result['commonContent']['settings']['website_name'])?>">
                        @endif
                    </a>
                </div>

                <div class="col-2 pl-0">
                    <ul class="pro-header-right-options" id="resposive-header-cart">
                        @include('web.headers.cartButtons.cartButton')
                    </ul>
                </div>
            </div>
        </div>
    </div>
    </div>
    </div>
    @include('web.common.HeaderCategories2')
    <div class="header-navbar bg-menu-bar">
        <div class="container">
            <form class="form-inline" action="{{ URL::to('/shop')}}" method="get">
                <div class="search">
                    <div class="select-control">
                        <select class="form-control" name="category">
                            <?php productCategories2(); ?>
                        </select>
                    </div>
                    <input  type="search" name="search" placeholder="@lang('website.Search entire store here')..."  value="{{ app('request')->input('search') }}">
                    <button class="btn btn-secondary" type="submit">
                        <i class="fa fa-search"></i></button>
                </div>
            </form>
        </div>
    </div>
</header>
