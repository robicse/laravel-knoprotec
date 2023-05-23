<?php
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('login', 'API\UserController@login');
Route::post('register', 'API\UserController@register');
Route::post('vendor/registration', 'API\UserController@vendorRegister' );
Route::group(['middleware' => 'auth:api'], function () {
    Route::post('details', 'API\UserController@details');
});
Route::post('user/details', 'API\UserController@details');
Route::post('user/profile/update', 'API\UserController@profile_update');
Route::post('user/password', 'API\UserController@password_reset');

Route::post('user/shipping-address/post', 'API\UserController@shipping_address_post');
Route::post('user/shipping-address/edit', 'API\UserController@shipping_address_edit');
Route::post('user/shipping-address/delete', 'API\UserController@shipping_address_delete');
Route::post('user/shipping-address/get', 'API\UserController@shipping_address_get');

Route::post('user/place-order', 'API\UserController@place_order');
Route::post('user/order', 'API\UserController@order');
Route::post('user/order/details', 'API\UserController@order_details');
Route::post('user/order/cancel', 'API\UserController@order_cancel');

Route::get('category', 'API\CategoriesController@category');
Route::post('subcategory', 'API\CategoriesController@subcategory');

Route::post('category/products', 'API\CategoriesController@categoryByProduct');
//Route::post('subcategory/products', 'API\CategoriesController@subcategoryByProduct');

Route::post('product', 'API\CategoriesController@product');
Route::get('special/product', 'API\CategoriesController@special_product');
Route::get('top-seller/product', 'API\CategoriesController@top_seller_product');
Route::get('most-liked/product', 'API\CategoriesController@most_liked');
Route::get('newest/product', 'API\CategoriesController@newest_product');

Route::post('product/search', 'API\CategoriesController@productSearch');

Route::post('/checkout/ssl/pay', 'API\PublicSslCommerzPaymentController@index');
Route::POST('/success', 'API\PublicSslCommerzPaymentController@success');
Route::POST('/fail', 'API\PublicSslCommerzPaymentController@fail');
Route::POST('/cancel', 'API\PublicSslCommerzPaymentController@cancel');
Route::POST('/ipn', 'API\PublicSslCommerzPaymentController@ipn');

Route::get('/ssl/redirect/{status}','API\PublicSslCommerzPaymentController@status');