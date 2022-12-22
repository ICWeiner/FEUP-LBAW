<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\Product;


class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * 
     */
    public static function create(Request $request) {

        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {

            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'number_pop'=> 'required|integer',
                'price'     => 'required|numeric',
                'stock_quantity'     => 'required|integer',
                'url'       => 'required|string',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);

            $product = Product::find($product_data['id_product']);
            #$product->done = $product_data->input('done');
            $product->name = $product_data['name'];
            $product->price = $product_data['price'];
            $product->stock_quantity = $product_data['stock_quantity'];
            $product->url = $product_data['url'];
            $product->year = $product_data['year'];
            #$product->rating = $request['rating'];
            $product->sku = $product_data['sku'];
            return redirect()->back();
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $product = Product::find($id);
        return view('pages.product', ['product' => $product]);
    }

    public function showUpdateForm(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        $product = product::find($request['id_product']);
        return view('pages.updateProduct', [ 'product' => $product]);
    }

    public function showReviews()
    {
        return view('pages.reviews');
    }


    /**
     * Shows all products
     *
     * @return Response
     */
    public function list()
    {
        $products = Product::all();//products()->orderBy('id')->get();
        return view('pages.products', ['products' => $products]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {

            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'price'     => 'required|numeric',
                'stock_quantity'     => 'required|integer',
                'url'       => 'required|string',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);


            $product = Product::find($request['id_product']);
            #$product->done = $request->input('done');
            $product->name = $request['name'];
            $product->price = $request['price'];
            $product->stock_quantity = $request['stock_quantity'];
            $product->url = $request['url'];
            $product->year = $request['year'];
            #$product->rating = $request['rating'];
            $product->sku = $request['sku'];
            $product->save();

            return redirect('products/' . $request['id_product']);

        }
        return redirect('/');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {
            $product = Product::find($request['id_product']);
            $product->delete();
            return redirect('products/');
        }
        return redirect('/');
    }
}