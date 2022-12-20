<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;



class CartController extends Controller
{
    public function showCart()
    {
        $user = Auth::user();

        $products = $user->cart()->get();

        $total = $products->sum(function($t){ 
            return $t->price*$t->pivot->quantity; 
        });

        #TODO get adress here?

        return view('pages.cart',['total'=> $total, 'products'=> $products]);
        /*
        $products = [];
        if (Null !== Session::get('cart')) {
            foreach (Session::get('cart') as $id) {
                $product = Product::find($id);
                $products[] = $product;
            }
        }
        //print_r(Session::get('cart'));
        return view('pages.cart', ['products' => $products]);*/
    }

    public function addToCart(Request $request)
    {

        $user = Auth::user();

        $product = Product::findOrFail($request->id_product);

        if ($user->cart()->where('product.id_product', $request->id_product)->count() > 0){#TODO: make this better
            return response(json_decode("Product already in cart"),500);
        }

        if ($product != null){
            $user->cart()->attach($product,array('quantity' => 1));
            return response(json_decode("Product added to cart"),200);
        }else{
            return response(json_decode("Product doesn't exist"),404);
        }

        /*
        if (!Session::has('cart')) {
            $cart = array(Request::post('id_product'));
        }
        $cart = Session::get('cart');
        //$cart->array_push(Request::post('id_product'));

        Session::push('cart', Request::post('id_product'));
        */
        return redirect('/');
    }

    public function removeProductFromCart(Request $request){
        $user = Auth::user();
        
        $product = $user->cart()->where('id_product',$request->id)->first();

        if ($product != null){
            $user->cart()->detach($product,array('quantity' => 1));
            $products = $user->cart()->get();
            $total = $products->sum(function($t){ 
                return $t->price*$t->pivot->quantity; 
            });
            return response(json_encode(array("Product removed from cart","Price" => $total)),200);
        }else{
            return response(json_encode(array("Product doesn't exist in cart","Price"=> null)),404);
        }
    }

    public function updateCartProduct(Request $request){
        $user = Auth::user();

        $product = $user->cart()->where('id_product',$request->id)->first();

        if ($product != null){
            $product->pivot->quantity = intval($request->quantity);
            $product->pivot->update();

            $products = $user->cart()->get();
            $total = $products->sum(function($t){ 
                return $t->price*$t->pivot->quantity; 
            });

            return response(json_encode(array("Product removed from cart","Price" => $total)),200);
        }else{
            return response(json_encode(array("Product doesn't exist in cart","Price"=> null)),404);

        }
    }
}
