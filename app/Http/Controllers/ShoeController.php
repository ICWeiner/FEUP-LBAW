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
                'stock'     => 'required|integer',
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
                'rating' => 1,
                'sku' => $request['sku'],
            ]);

            $product->save();

            $shoe = Shoe::create([
                'id_product' => $product->id_product,
                'name' => $request['name'],
                'type_name' => $request['type_name'],
                'brand_name' => $request['brand_name'],
            ]);

            $shoe->save();

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

    public function showUpdateForm()
    {
        return view('pages.updateShoe');
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
        $this->validate($request, [
            'name'      => 'required|string|max:255',
            'type_name'      => 'required|string|max:255',
            'brand_name'      => 'required|string|max:255',
            'price'     => 'required|integer',
            'stock'     => 'required|integer',
            'url'       => 'required|string',
            'year'      => 'required!integer',
        ]);

        $shoes = shoe::find($id);
        $shoes->done = $request->input('done');
        $shoes->save();
        $product = Product::find($id);
        $product->done = $request->input('done');
        $product->save();
        return $shoes;
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
