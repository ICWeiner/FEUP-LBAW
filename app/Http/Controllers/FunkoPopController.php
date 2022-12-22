<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\funkoPop;
use App\Models\Product;
use App\Http\Controllers\ProductController;

class FunkoPopController extends Controller
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
        if (!Auth::check()) return redirect('/login');
        return view('pages.addFunkoPops');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {
            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'number_pop' => 'required|integer',
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


            funkoPop::create([
                'id_product' => $product->id_product,
                'number_pop' => $request['number_pop'],
            ]);

            return redirect('addFunkoPops');
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
     * @param  \App\Models\funkoPop  $funkoPop
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $funkoPop = funkoPop::find($id);
        return view('pages.funkoPop', ['funkoPop' => $funkoPop]);
    }

    /**
     * Shows all products
     *
     * @return Response
     */
    public function list()
    {
        $funkoPops = funkoPop::all();
        return view('pages.funkoPops', ['funkoPops' => $funkoPops]);
    }

    public function showUpdateForm(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        $funko = funkoPop::find($request['id_product']);
        $product = product::find($request['id_product']);
        return view('pages.updateFunkoPop', ['funko' => $funko, 'product' => $product]);
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
        /*
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

            $product_data = ['id_product'     => $request['id_product'],
                             'name'           => $request['name'],
                             'price'          =>  $request['price'],
                             'stock_quantity' => $request['stock_quantity'],
                             'url'            => $request['url'],
                             'year'           => $request['year'],
                             #'rating'=> ,
                             'sku'            => $request['sku'],];

            if(!ProductController::update($product_data)) return;#TODO couldnt save, do something



            $funko = funkoPop::find($request['id_product']);
            $funko->number_pop = $request['number_pop'];
            #$shoe->done = $request->input('done');
            $funko->save();*/

        }
        return redirect('funkoPops');
    }


    public function destroy(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        $funko = funkoPop::find($request['id_product']);
        $product = Product::find($request['id_product']);

        #$product->reviews()->delete(); #TODO: changes this behaviour, we dont actually want this, we just want to showcase we can delete stuff for A8
        $funko->delete();
        #$product->delete();
        return redirect('funkoPops');
    }
}
