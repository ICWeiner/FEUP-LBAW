<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Client\Request as ClientRequest;
use Session;
use Illuminate\Http\Request;

class CartController extends Controller
{
    public function showCart()
    {
        $products = [];
        if (Null !== Session::get('cart')) {
            foreach (Session::get('cart') as $id) {
                $product = Product::find($id);
                $products[] = $product;
            }
        }
        //print_r(Session::get('cart'));
        return view('pages.cart', ['products' => $products]);
    }

    public function addToCart(Request $request)
    {
        /*
        if (!Session::has('cart')) {
            $cart = array(Request::post('id_product'));
        }
        $cart = Session::get('cart');
        //$cart->array_push(Request::post('id_product'));

        Session::push('cart', Request::post('id_product'));

        return redirect('/');*/

        session()->put('cart', $request->post('cart'));

        return response()->json([
            'status' => 'added'
        ]);
    }
}
