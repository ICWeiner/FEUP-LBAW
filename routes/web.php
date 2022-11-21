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

//static pages
//Route::get('/', 'StaticController@index');
Route::get('about', 'StaticController@about');
Route::get('services', 'StaticController@services');
Route::get('faq', 'StaticController@faq');
Route::get('contact', 'StaticController@contact');


//products
Route::get('products', 'ProductController@list');
Route::get('products/{id}', 'ProductController@show');

//shoes
Route::get('shoes', 'ShoeController@list');
Route::get('shoes/{id}', 'ShoeController@show');
Route::get('addShoes', 'ShoeController@showCreateForm')->name('addShoes');
Route::post('addShoes', 'ShoeController@create');

//books
Route::get('books', 'BookController@list');
Route::get('books/{id}', 'BookController@show');

//funkoPops
Route::get('funkoPops', 'FunkoPopController@list');
Route::get('funkoPops/{id}', 'FunkoPopController@show');

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

//User Management
Route::get('user', 'UserController@show')->name('user');
Route::get('editUser', 'UserController@showEditForm')->name('editUser');
Route::post('editUser', 'UserController@edit');
