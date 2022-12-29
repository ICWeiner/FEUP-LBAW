<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
// Home
Route::get('/', 'ProductController@list')->name('home');;

//static pages
Route::get('about', 'StaticController@about');
Route::get('faq', 'StaticController@faq');
Route::get('contact', 'StaticController@contact');

//products
Route::get('products', 'ProductController@list');
Route::get('products/shoes', 'ProductController@listShoes');
Route::get('products/books', 'ProductController@listBooks');
Route::get('products/funkoPops', 'ProductController@listFunkos');
Route::get('products/{id}', 'ProductController@show');




Route::get('updateProduct', 'ProductController@showUpdateForm')->name('updateProduct');
Route::post('updateProduct', 'ProductController@update');
Route::post('deleteProduct', 'ProductController@destroy')->name('deleteProduct');
Route::get('addProduct', 'ProductController@showCreateForm');
Route::post('addProduct', 'ProductController@create')->name('addProduct');

//Cart
Route::get('cart', 'CartController@show')->name('cart');

//Wishlist
Route::get('wishlist', 'WishlistController@list')->name('wishlist');

//Orders
Route::get('orders/{id}', 'OrdController@show');
Route::post('createOrder', 'OrdController@create')->name('createOrder');
Route::get('orderSuccess', 'OrdController@orderSuccess')->name('orderSuccess');

//Review
Route::post('addReview', 'ReviewController@create')->name('addReview');
Route::post('addComment', 'CommentController@create')->name('addComment');

// API
Route::put('api/cart/{id_product}', 'CartController@addToCart');
Route::post('api/cart/{id_product}', 'CartController@updateCartProduct');

Route::put('api/wishlist/{id_product}', 'WishlistController@updateWishlist');


// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');;
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');

Route::get('password/reset/{token}', 'Auth\ResetPasswordController@showResetForm')->name('password.reset');
Route::post('password/reset', 'Auth\ResetPasswordController@reset')->name('password.update');

Route::get('password/email', 'Auth\ForgotPasswordController@showLinkRequestForm')->name('password.email');
Route::post('password/email', 'Auth\ForgotPasswordController@getEmail')->name('password.email');

//User Management
Route::get('user', 'UserController@show')->name('user');
Route::get('editUser', 'UserController@showEditForm')->name('editUser');
Route::post('editUser', 'UserController@edit');
Route::get('showOrders', 'UserController@showOrders');
Route::get('deleteUser', 'UserController@destroy')->name('deleteUser');

//Admin area
Route::get('adminDashboard', 'AdminController@dashboard')->name('adminDashboard');

Route::get('adminItemsDashboard', 'AdminController@itemDashboard')->name('adminItemsDashboard');

Route::get('adminUsersDashboard', 'AdminController@userDashboard')->name('adminUsersDashboard');
Route::get('adminEditUser', 'AdminController@userEditForm')->name('adminEditUser');
Route::post('adminEditUser', 'AdminController@userEdit');

Route::post('adminBanUser', 'AdminController@banUser')->name('adminBanUser');

//Search
Route::get('search', 'SearchController@show')->name('search');
