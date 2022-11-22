@extends('layouts.app')

@section('title', 'Store')

@section('content')

<section id="admin">
    <form method="GET" action="">
        <input type="submit" value="Review Flagged content" />
    </form>

    <form method="GET" action="{{ route('adminEditUser') }}">
    <select id="dropdown" name="id_user">
    @foreach ($users as $user )
        <option value="{{ $user->id_user }}">{{ $user->name }}</option>
    @endforeach
    </select>
    <input type="submit" value="Edit selected user's name" />
    </form>
</section>

@endsection
