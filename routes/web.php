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
Route::get('services', 'StaticController@services');
Route::get('faq', 'StaticController@faq');
Route::get('contact', 'StaticController@contact');

//products
Route::get('products', 'ProductController@list');
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

//shoes
Route::get('shoes', 'ShoeController@list');
Route::get('shoes/{id}', 'ShoeController@show');
Route::get('addShoes', 'ShoeController@showCreateForm')->name('addShoes');
Route::post('addShoes', 'ShoeController@create');
Route::get('updateShoe', 'ShoeController@showUpdateForm')->name('updateShoe');
Route::post('updateShoe', 'ShoeController@update');
Route::post('deleteShoe', 'ShoeController@destroy')->name('deleteShoe');

//books
Route::get('books', 'BookController@list');
Route::get('books/{id}', 'BookController@show');
Route::get('addBooks', 'BookController@showCreateForm')->name('addBooks');
Route::post('addBooks', 'BookController@create');
Route::get('updateBook', 'BookController@showUpdateForm')->name('updateBook');
Route::post('updateBook', 'BookController@update');
Route::post('deleteBook', 'BookController@destroy')->name('deleteBook');

//funkoPops
Route::get('funkoPops', 'FunkoPopController@list');
Route::get('funkoPops/{id}', 'FunkoPopController@show');
Route::get('addFunkoPops', 'FunkoPopController@showCreateForm')->name('addFunkoPops');
Route::post('addFunkoPops', 'FunkoPopController@create');
Route::get('updateFunkoPop', 'FunkoPopController@showUpdateForm')->name('updateFunkoPop');
Route::post('updateFunkoPop', 'FunkoPopController@update');
Route::post('deleteFunkoPop', 'FunkoPopController@destroy')->name('deleteFunkoPop');


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
Route::get('recoverPassword', 'Auth\RegisterController@recoverPassword')->name('recoverPassword');

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
//Route::get('editUser', 'UserController@showEditForm')->name('editUser');
//Route::post('editUser', 'UserController@edit');


Route::get('search', 'SearchController@show')->name('search');
