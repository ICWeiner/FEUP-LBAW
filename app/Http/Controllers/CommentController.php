<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\comment;

class CommentController extends Controller
{


    public function index()
    {
        //
    }

    public function create(Request $request)
    {
        if (Auth::check()) {
            $user = Auth::user();
            comment::create([
                'content' => $request['commentText'],
                'rating' => $request['rating'],
                'id_review' => $request['id_review'],
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