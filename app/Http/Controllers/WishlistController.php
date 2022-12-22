<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;



class WishlistController extends Controller
{

    public function updateWishlist(Request $request){

        try{

            if (!Auth::check()) return response()->json([
                'Message' => "You can´t do that >:(" ,
                ],400);;

            $user = Auth::user();
            
            if (!Product::where('id_product', $request->id_product )->exists()){
                return response()->json([
                    'Message' => 'Product not found',
                ],404);
            }

            /*return response()->json([
                'Message' => 'cool',
            ],200);*/
            
            $product = Product::where('id_product', $request->id_product )->first();
            
            if ($product !== null){
                $user->wishlist()->attach($request->id_product);
                return response()->json([
                    'Message' => 'Product added to wishlist',
                    'Product added' => $product->name,
                    ],200);
            }else{
                $user->wishlist()->detach($request->id_product);
                return response()->json([
                    'Message' => 'Product removed to wishlist',
                    'Product removed' => $product->name,
                    ],404);
            }

        }catch (\Exception $e) {
            return response()->json([
                'Message' => 'Error on wishlist operation',
                'error'=> $e,
            ],400);
        }
        
    }
}
