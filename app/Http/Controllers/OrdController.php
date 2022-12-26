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
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!Auth::check()) return redirect('/login');

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

        $this->authorize('create', $ord);

        foreach ($cart as $product) {
            $ord->products()->attach($product->id_product, ['quantity' => $product->pivot->quantity]);
        }

        $user->cart()->detach();
        return view('auth.orderSuccess',['id_ord'=> $ord->id_ord]);
            
        
    }

    public function orderSuccess()
    {
        return view('auth.orderSuccess');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\ord  $ord
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        if (!Auth::check()) return redirect('/login');
        $ord = ord::find($id);
        $this->authorize('view', $ord);
        return view('pages.ord', ['ord' => $ord]);
    }

    /**
     * Shows all products
     *
     * @return Response
     */
    public function list()
    {
        if (!Auth::check()) return redirect('/login');
        $this->authorize('list', Ord::class);
        $ords = Auth::user()->orders()->orderBy('id')->get();
        return view('pages.ords', ['ords' => $ords]);
    }
}
