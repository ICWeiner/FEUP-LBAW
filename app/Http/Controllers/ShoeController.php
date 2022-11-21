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

    public function showCreateForm() {
        return view('pages.addShoes');        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request) {
        $this->validate($request, [
            'name'      => 'required|string|max:255',
            'type_name' => 'required|string|max:255',
            'brand_name'=> 'required|string|max:255',
            'price'     => 'required|integer',
            'stock'     => 'required|integer',
            'url'       => 'required|string',
            'year'      => 'required|integer',
            'sku'       => 'required|string',
        ]);

        $product = new Product;
        $shoe = new shoe;
        $product->name = $request->get('name');
        $shoe->name = $request->get('name');
        $shoe->type_name = $request->get('type_name');
        $shoe->brand_name = $request->get('brand_name');
        $product->price = $request->get('price');
        $product->stock_quantity = $request->get('stock');
        $product->url = $request->get('url');
        $product->year = $request->get('year');
        $product->rating = 0;
        $product->sku = $request->get('sku');

        $product = $product->create();
        $shoe->id_product = $product->id_product;
        $shoe->save();

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

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
