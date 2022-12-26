<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\Product;
use App\Models\book;
use App\Models\funkoPop;
use App\Models\shoe;

class ProductController extends Controller
{

    public function showCreateForm()
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin !== true) return redirect('/');
        return view('admin.adminNewProductForm');
    }

    public function create(Request $request) {

        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {

            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'price'     => 'required|numeric',
                'stock_quantity'     => 'required|integer',
                'url'       => 'image|mimes:jpeg,png,jpg,gif|max:2048',
                'description'       => 'required|string|max:2048',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);

            
            $imagePath = null;
            if ( $request->url !== null){
                $imageName = time().'.'.$request->url->extension();   
                $request->url->move(public_path('images/products'), $imageName);

                $imagePath ='images/products/'.$imageName;
            }

            $product = Product::create([
            'name' => $request['name'],
            'price' => $request['price'],
            'rating' => 0,
            'stock_quantity' => $request['stock_quantity'],
            'description' => $request['description'],
            'url' => $imagePath,
            'year' =>  $request['year'],
            'sku' => $request['sku'],
            ]);
            

            return redirect('products/' . $product->id_product);      
        }
        return redirect('/');
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
        $products = Product::all();
        return view('pages.products', ['products' => $products]);
    }

    public function listBooks()
    {
        $books = book::all();
        $products = array();
        foreach ($books as $book){
            $product = Product::find($book->id_product);
            $products[] = $product;
        }
        return view('pages.products', ['products' => $products]);
    }

    public function listFunkos()
    {
        $funkoPops = funkoPop::all();
        $products = array();
        foreach ($funkoPops as $funkoPop){
            $product = Product::find($funkoPop->id_product);
            $products[] = $product;
        }
        return view('pages.products', ['products' => $products]);
    }

    public function listShoes()
    {

        $shoes = shoe::all();
        $products = array();
        foreach ($shoes as $shoe){
            $product = Product::find($shoe->id_product);
            $products[] = $product;
        }
        
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
                'description'       => 'required|string|max:2048',
                'url'       => 'image|mimes:jpeg,png,jpg,gif|max:2048',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);


            $product = Product::find($request['id_product']);

            
            if ( $request->url !== null){
                $imageName = time().'.'.$request->url->extension();   
                $request->url->move(public_path('images/products'), $imageName);
                
                $product->url ='images/products/'.$imageName;
            }

            $product->name = $request['name'];
            $product->price = $request['price'];
            $product->stock_quantity = $request['stock_quantity'];
            $product->year = $request['year'];
            $product->description = $request['description'];
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