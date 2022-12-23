@extends('layouts.app')

@section('title', 'Store')

@section('content')
<div class="mb-5">
    <p class="lead fw-normal mb-1">Actions</p>
    <div class="p-4" style="background-color: #f8f9fa;">
    @if (Auth::user()->user_is_admin === true)
    <div class="mx-auto">
        <form method="GET" style="margin-bottom:1.5em"  action="{{ route('adminEditUser') }}">
        <select id="dropdown" name="id_user">
            @foreach ($users as $user )
                <option value="{{ $user->id_user }}">{{ $user->name }}</option>
            @endforeach
            </select>
        <input class="btn btn-primary" type="submit" value="Edit selected user's name" />
        </form>
    </div>

    <div class="mx-auto">  
        <div class="d-grid">
            <form method="GET" action="{{ route('adminBanUser') }}">
            <select id="dropdown" name="id_user">
            @foreach ($users as $user )
                <option value="{{ $user->id_user }}">{{ $user->name }}</option>
            @endforeach
            </select>
            <input class="btn btn-primary" type="submit" value="Ban selected user name" />
            </form>
        </div>
    @endif
    </div>
    </div>
</div>

@endsection
