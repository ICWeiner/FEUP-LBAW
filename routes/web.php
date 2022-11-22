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
Route::get('/', 'Auth\LoginController@home');

// Cards
#Route::get('cards', 'CardController@list');
#Route::get('cards/{id}', 'CardController@show');

//products
Route::get('products', 'ProductController@list');
Route::get('products/{id}', 'ProductController@show');

//Cart
Route::get('cart', 'CartController@showCart')->name('cart');
Route::post('addToCart', 'CartController@addToCart')->name('addToCart');

// API
#Route::put('api/cards', 'CardController@create');
#Route::delete('api/cards/{card_id}', 'CardController@delete');
#Route::put('api/cards/{card_id}/', 'ItemController@create');
#Route::post('api/item/{id}', 'ItemController@update');
#Route::delete('api/item/{id}', 'ItemController@delete');

// Authentication
Route::get('login', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('login', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');
Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register');
Route::get('recoverPassword', 'Auth\RegisterController@recoverPassword')->name('recoverPassword');

//User Management
Route::get('user', 'UserController@show')->name('user');
Route::get('editUser', 'UserController@showEditForm')->name('editUser');
Route::post('editUser', 'UserController@edit');
