<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Models\ord;
use Session;

class OrdController extends Controller
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
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        
        if (Auth::check()) {
            $user = Auth::user();
            $cart = $user->cart()->get();
            $total = $cart->sum(function($t){ 
                return $t->price*$t->pivot->quantity; 
            });

            $ord = ord::create([
                'id_user' => $user->id_user,
                'id_status' => 1,
                'total_price' => $total,
                'tracking_number' => 452333,
                'buy_date' => now(),
            ]);

            foreach ($cart as $product) {
                $ord->products()->attach($product->id_product, ['quantity' => $product->pivot->quantity]);
            }
        }
        return redirect('/orderSuccess');
    }

    public function orderSuccess()
    {
        return view('auth.orderSuccess');
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
     * @param  \App\Models\ord  $ord
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $ord = ord::find($id);
        return view('pages.ord', ['ord' => $ord]);
    }

    /**
     * Shows all products
     *
     * @return Response
     */
    public function list()
    {
        $ords = ord::all();
        return view('pages.ords', ['ords' => $ords]);
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
