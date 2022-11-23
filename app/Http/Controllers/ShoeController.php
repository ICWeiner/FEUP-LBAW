<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\shoe;
use App\Models\Product;

class ShoeController extends Controller
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

    public function showCreateForm()
    {
        return view('pages.addShoes');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        if (Auth::user()->user_is_admin === true) {

            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'type_name' => 'required|string|max:255',
                'brand_name' => 'required|string|max:255',
                'price'     => 'required|integer',
                'stock_quantity'     => 'required|integer',
                'url'       => 'required|string',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);

            $product = Product::create([
                'name' => $request['name'],
                'price' => $request['price'],
                'stock_quantity' => $request['stock_quantity'],
                'url' => $request['url'],
                'year' => $request['year'],
                'rating' => 0,
                'sku' => $request['sku'],
            ]);

            Shoe::create([
                'id_product' => $product->id_product,
                'name' => $request['name'],
                'type_name' => $request['type_name'],
                'brand_name' => $request['brand_name'],
            ]);

            return redirect('addShoes');
        }
        return redirect('products');
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
     * @param  \App\Models\shoe  $shoe
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $shoe = shoe::find($id);
        return view('pages.shoe', ['shoe' => $shoe]);
    }

    /**
     * Shows all products
     *
     * @return Response
     */
    public function list()
    {
        $shoes = shoe::all();
        return view('pages.shoes', ['shoes' => $shoes]);
    }

    public function showUpdateForm(Request $request)
    {
        $shoe = shoe::find($request['id_product']);
        $product = product::find($request['id_product']);
        return view('pages.updateShoe', ['shoe' => $shoe, 'product' => $product]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {

        if (Auth::user()->user_is_admin === true) {

            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'type_name' => 'required|string|max:255',
                'brand_name' => 'required|string|max:255',
                'price'     => 'required|numeric',
                'stock_quantity'     => 'required|integer',
                'url'       => 'required|string',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);

            $shoe = shoe::find($request['id_product']);
            $shoe->name = $request['name']; # TODO: THIS MODEL HAS THE NAME REPEATED FIIIIIIIIIIIX
            $shoe->type_name = $request['type_name'];
            $shoe->brand_name = $request['brand_name'];
            #$shoe->done = $request->input('done');
            $shoe->save();

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
        }
        return redirect('shoes');
    }


    public function destroy(Request $request)
    {
        $shoe = shoe::find($request['id_product']);
        $product = Product::find($request['id_product']);

        $shoe->options()->delete();
        #$product->reviews()->delete(); #TODO: changes this behaviour, we dont actually want this, we just want to showcase we can delete stuff for A8
        $shoe->delete();
        #$product->delete();
        return redirect('shoes');
    }
}
