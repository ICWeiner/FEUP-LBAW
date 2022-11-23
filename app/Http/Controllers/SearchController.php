<?php

namespace App\Http\Controllers;

use App\Models\Product;

use Illuminate\Http\Request;

class SearchController extends Controller
{
  
    public function show(Request $request){

        if($request->input('search')){
            $products = Product::where('name','like','%'.$request->input('search').'%')->get();
            
        }else{
            $products = Product::all();
        }


        return view('pages.searchResults',['products' => $products]);
    }
 
}
