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
        return redirect('/');
    }
}

