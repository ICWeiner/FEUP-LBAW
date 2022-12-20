<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\review;

class ReviewController extends Controller
{


    public function index()
    {
        //
    }

    public function create(Request $request)
    {
        if (Auth::check()) {
            $user = Auth::user();
            review::create([
                'comment' => $request['reviewText'],
                'rating' => $request['rating'],
                'review_date' => now(),
                'id_product' => $request['id_product'],
                'id_user' =>  $user->id_user,
            ]);
            
        }
        return redirect()->back();
    }


    public function store(Request $request)
    {
        //
    }


    public function show($id)
    {
        //
    }


    public function edit($id)
    {
        //
    }


    public function update(Request $request, $id)
    {
        //
    }


    public function destroy($id)
    {
        //
    }
}