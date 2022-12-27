<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\review;

class ReviewController extends Controller
{


    public function create(Request $request)
    {

        
        if (!Auth::check()) return redirect('/login');

        $this->validate($request, [
            'reviewText'  => 'required|string|max:2048',
            'rating'      => 'required|integer',
            'id_product'  => 'required|integer',
        ]);

        $user = Auth::user();

        review::create([
            'comment' => $request['reviewText'],
            'rating' => $request['rating'],
            'review_date' => now(),
            'id_product' => $request['id_product'],
            'id_user' =>  $user->id_user,
        ]);
        
        return redirect()->back();
    }


}