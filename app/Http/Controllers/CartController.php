<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;


class CartController extends Controller{
    public function showCart()  {
        $products[0] = Product::find(1);
        return view('pages.cart', ['products' => $products]);
    }

    public function addToCart(){
        //$request->session()->push('cartItems', 'id_product');
        $item = [
            'id' => ['id_product' => ($products[0] = Product::find(1))],
        ];

        Session::push('cart', $item);

        $items = Session::get('cart');
        
        return redirect('/');
    }
}

