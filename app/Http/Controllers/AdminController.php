<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AdminController extends Controller
{

    public function dashboard()
    {
        if (Auth::user()->user_is_admin === true)
            return view('admin.adminDashboard');
    }

    public function itemDashboard()
    {
        if (Auth::user()->user_is_admin === true) {
            return view('admin.adminItemsDashboard');
        }
    }

    public function userDashboard()
    {
        if (Auth::user()->user_is_admin === true) {
            return view('admin.adminUsersDashboard');
        }
    }
}
