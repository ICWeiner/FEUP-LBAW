<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Database\Eloquent\Relations\Pivot;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;



class WishlistController extends Controller
{

    /**
     * Shows all wishlisted products
     *
     * @return Response
     */
    public function list()
    {
        if (!Auth::check()) return redirect('/login');
        $user = Auth::user();
        $products = $user->wishlist()->get();//products()->orderBy('id')->get();
        return view('pages.products', ['products' => $products]);
    }

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
            
            $product = Product::find($request->id_product);
            
            if (!$user->wishlist()->where('product.id_product',$request->id_product)->exists() ){
                $user->wishlist()->attach($request->id_product,['date_added' => now()]);
                return response()->json([
                    'Message' => 'Product added to wishlist',
                    'Product added' => $product->name,
                    ],200);
            }else{
                $user->wishlist()->detach($request->id_product);
                return response()->json([
                    'Message' => 'Product removed to wishlist',
                    'Product removed' => $product->name,
                    'id' => $request->id_product,
                    ],200);
            }

        }catch (\Exception $e) {
            return response()->json([
                'Message' => 'Internal server error on wishlist operation',
            ],400);
        }
        
    }
}
