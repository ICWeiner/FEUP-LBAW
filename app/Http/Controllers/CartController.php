<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;



class CartController extends Controller
{
    public function show()
    {
        if (!Auth::check()) return redirect('/login');
        $user = Auth::user();

        $products = $user->cart()->get();

        $total = $products->sum(function($t){ 
            return $t->price*$t->pivot->quantity; 
        });

        return view('pages.cart',['total'=> $total, 'products'=> $products]);

    }

    public function addToCart(Request $request)
    {
        
        try{
            if (!Auth::check()) return response()->json([
                'Message' => "You can´t do that >:(" ,
                ],400);

            if (!Product::where('id_product', $request->id_product )->exists()){
                return response()->json([
                    'Message' => 'Product not found',
                ],404);
            }
        
            $user = Auth::user();

            if($user->cart()->where('product.id_product',$request->id_product)->exists()){
                return response()->json([
                    'Message' => 'Product already in cart',
                    ],500);
            }else{
                $user->cart()->attach($request->id_product,array('quantity' => $request->quantity));
                return response()->json([
                    'Message' => 'Product added to cart',
                    ],200);
            }

        }catch (\Exception $e) {
            return response()->json([
                'Message' => 'Error adding product to cart',
            ],400);
        }
    }

    public function updateCartProduct(Request $request){

        if (!Auth::check()) return redirect('/login');
        try{
            $user = Auth::user();

            $products = $user->cart()->where('product.id_product',$request->id_product)->first();
            
            if ($products != null){
                if($request->quantity == 0){
                    $user->cart()->detach($request->id_product);
                }else{
                    $products->pivot->quantity = intval($request->quantity);
                    $products->pivot->update();
                }
    
                $products = $user->cart()->get();
                $total = $products->sum(function($t){ 
                    return $t->price*$t->pivot->quantity; 
                });

                return response()->json([
                    'Message' => 'Cart updated',
                    'total' => $total,
                    'new_quantity' => $request->quantity,
                    'id' => $request->id_product,
                    'array' => $products,
                    ],200);
            }else{
                return response()->json([
                    'Message' => "Product doesn't exist in cart",
                    #'total' => $total,
                    ],404);
            }

        }catch (\Exception $e) {
            return response()->json([
                'Message' => 'Error updating product on cart',
                'error'=> $e,
            ],400);
        }
        
    }
}
