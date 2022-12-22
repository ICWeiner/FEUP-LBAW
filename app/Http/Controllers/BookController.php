<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\book;
use App\Models\publisher;
use App\Models\author;
use App\Models\Product;

class BookController extends Controller
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
        return view('pages.addBooks');
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
                'author_name'      => 'required|string|max:255',
                'author_url'       => 'required|string',
                'publisher_name'      => 'required|string|max:255',
                'book_name'      => 'required|string|max:255',
                'edition'     => 'required|integer',
                'ISBN'       => 'required|string',
                'price'     => 'required|integer',
                'stock_quantity'     => 'required|integer',
                'url'       => 'required|string',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);

            $product = Product::create([
                'name' => $request['book_name'],
                'price' => $request['price'],
                'stock_quantity' => $request['stock_quantity'],
                'url' => $request['url'],
                'year' => $request['year'],
                'rating' => 0,
                'sku' => $request['sku'],
            ]);

            author::create([
                'name' => $request['author_name'],
                'url' => $request['author_url'],
            ]);

            $publisher = publisher::create([
                'name' => $request['publisher_name'],
            ]);

            book::create([
                'id_product' => $product->id_product,
                'edition' => $request['edition'],
                'isbn' => $request['ISBN'],
                'id_publisher' => $publisher->id_publisher,
            ]);

            return redirect('addBooks');
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
     * @param  \App\Models\book  $book
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $book = book::find($id);
        return view('pages.book', ['book' => $book]);
    }



    /**
     * Shows all products
     *
     * @return Response
     */
    public function list()
    {
        $books = book::all();
        return view('pages.books', ['books' => $books]);
    }



    public function showUpdateForm(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        $book = book::find($request['id_product']);
        $product = product::find($request['id_product']);
        return view('pages.updateBook', ['book' => $book, 'product' => $product]);
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
        /*TODO: WIP, finish this
        if (Auth::user()->user_is_admin === true) {


            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'number_pop' => 'required|integer',
                'price'     => 'required|numeric',
                'stock_quantity'     => 'required|integer',
                'url'       => 'required|string',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);

            $this->validate($request, [
                'author_name'      => 'required|string|max:255',
                'author_url'       => 'required|string',
                'publisher_name'      => 'required|string|max:255',
                'name'      => 'required|string|max:255',
                'edition'     => 'required|integer',
                'ISBN'       => 'required|string',
                'price'     => 'required|numeric',
                'stock_quantity'     => 'required|integer',
                'url'       => 'required|string',
                'year'      => 'required|integer',
                'sku'       => 'required|string',
            ]);


            $funko = funkoPop::find($request['id_product']);

            $funko->number_pop = $request['number_pop'];
            #$shoe->done = $request->input('done');
            $funko->save();

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
        }*/
        return redirect('books');
    }

    public function destroy(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        $book = book::find($request['id_product']);
        $product = Product::find($request['id_product']);

        #$book->options()->delete();
        #$product->reviews()->delete(); #TODO: changes this behaviour, we dont actually want this, we just want to showcase we can delete stuff for A8
        $book->delete();
        #$product->delete();
        return redirect('books');
    }
}
