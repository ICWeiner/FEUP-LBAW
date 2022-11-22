@extends('layouts.app')

@section('content')

<section id="admin">
    <form method="POST" action="{{ route('adminEditUser') }}">
        {{ csrf_field() }}
        <input name="id_user" value="{{  Request::get('id_user') }}" required hidden>
        <label for="name">New name</label>
        <input id="name" type="text" name="name" value="{{ old('name') }}" required autofocus>
        @if ($errors->has('name'))
        <span class="error">
            {{ $errors->first('name') }}
        </span>
        @endif
        <input type="submit" value="Edit selected user's name" />
    </form>
</section>




@endsection
