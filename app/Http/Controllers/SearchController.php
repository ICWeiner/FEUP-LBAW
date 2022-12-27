<?php

namespace App\Http\Controllers;

use App\Models\Product;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class SearchController extends Controller
{
  
    public function show(Request $request){

        if($request->exists('search')){
            $products = Product::where(DB::raw('lower(name)'),"LIKE", Str::lower("%{$request->search}%"))->get();

            #$products = Product::whereRaw(" name @@ plainto_tsquery('" . $request->search . "')")->paginate(8);

            return view('pages.products',['products' => $products]);
        }
       return redirect('/');
        
    }
 
}
