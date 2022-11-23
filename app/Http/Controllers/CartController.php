<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Session;
use Request;

class CartController extends Controller{
    public function showCart()  {
        $products = [];
        foreach (Session::get('cart') as $id) {
            $product = Product::find($id);
            $products[] = $product;
        }
        print_r(Session::get('cart'));
        return view('pages.cart', ['products' => $products]);
    }

    public function addToCart(){
        if(!Session::has('cart')){
            $cart = array(Request::post('id_product'));
            Session::put('cart', $cart);
        }
        $cart = Session::get('cart');
        //$cart->array_push(Request::post('id_product'));
        
        Session::push('cart', Request::post('id_product'));
        
        return redirect('/');
    }
}

