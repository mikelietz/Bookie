<script type="text/template" id="bmark_row">
    <div class="tags">
        {{#each tags}}
            <a class="tag" href="">{{name}}</a>
        {{/each}}
    </div>

    <div class="description">
        <a href="/redirect/{{hash_id}}"
            title="{{extended}}">
            <img class="favicon" src="https://s2.googleusercontent.com/s2/favicons?domain={{domain}}" />
            {{#if description}}
                {{description}}
            {{else}}
                [no title]
            {{/if}}
        </a>
    </div>

    <div class="actions">
        <span aria-hidden="true" class="icon icon-calendar" title="{{prettystored}}"></span>
        <em class="icon">Date Stored</em>

        <a href="/bmark/readable/{{hash_id}}"
           title="View readable content"
           alt="View readable content"
           class="readable">
           <span aria-hidden="true" class="icon icon-eye-open"></span>
           <em class="icon">View readable content</em>
        </a>

        {{#if owner}}
            <a href="/{{username}}/edit/{{hash_id}}"
                title="Edit the bookmark" alt="Edit the bookmark"
                class="edit">
                <span aria-hidden="true" class="icon icon-pencil"></span>
                <em class="icon">Edit bookmark</em>
            </a>

            <a href="#" title="Delete the bookmark" alt="Delete the bookmark"
               class="delete">
                <span aria-hidden="true" class="icon icon-remove"></span>
                <em class="icon">Delete bookmark</em>
            </a>
       {{/if}}
    </div>
    {{#unless owner}}
        <div class="user">
            <a href="/{{username}}/recent" title="View {{username}}'s bookmarks">{{username}}</a>
        </div>
    {{/unless}}
    <div class="url" title="{{url}}">
        <a href="/bmark/readable/{{hash_id}}"
           title="View readable content" alt="View readable content">
           <span aria-hidden="true" class="icon icon-eye-open"></span>
           <em class="icon">View readable content</em>
        </a> {{url}}
    </div>
</script>


<script type="text/template" id="previous_control">
    {{#if show_previous}}
        <a href="#" class="button previous"><span aria-hidden="true"
        class="icon icon-arrow-left"></span><span class="desc">Prev</span></a>
    {{/if}}
</script>

<script type="text/template" id="next_control">
    {{#if show_next}}
        <a href="#" class="button next"><span class="desc">Next</span><span
        class="icon icon-arrow-right"
        aria-hidden="true"></span></a>
    {{/if}}
</script>

<script type="text/template" id="bmark_list">
    <div class="controls">
        <div class="" style="float: right;">
            <div class="buttons paging" style="display: inline-block;"></div>
        </div>

        {{#if current_user}}
            <div class="buttons add" style="display: inline-block; vertical-align: middle;">
                <a href="/{{current_user}}/new"
                    class="button">
                    <span class="icon icon-plus"
                    aria-hidden="true"></span> <span class="desc">Add Bookmark</span>
                </a>
            </div>
        {{/if}}

        <div class="filter_control">
            {{{filter_control}}}
        </div>
    </div>

    <div class="data_list"></div>

    <div class="controls">
        <div class="" style="float: right;">
            <div class="buttons paging" style="display: inline-block;"></div>
        </div>
    </div>
</script>


<script type="text/template" id="filter_container">
    <div class="tag_filter_container" style="">
        <input name="tag_filter" id="tag_filter" value=""/>
    </div>
</script>

<script type="text/template" id="account_invites">
    <div class="form">
        <a href="" id="invite_heading" class="heading">
            <span aria-hidden="true" class="icon icon-envelope" title="You have invites!"></span>
            <em class="icon">Invite</em>
            You have invites!
        </a>
        <div id="invite_body" style="display: none; opacty: 0;">
            <p>Please, invite others to join Bookie and Bmark.us.</p>
            <form id="#invite_form">
                <ul>
                    <li>
                        <label>Email Address</label>
                        <input type="text" id="invite_email" name="invite_email" />
                        <input type="submit" id="send_invite" name="send_invite" value="Send" />
                    </li>
                </ul>
            </form>
            <div class="details">
                <p>
                    You have <span class="invite_count">{{invite_ct}}</span> invites left.
                </p>
            </div>
        </div>
        <div id="invite_msg" class="error"></div>
    </div>
</script>

<script type="text/template" id="new_user">
    <div id="new_user_welcome">
        <h3 class="heading">Welcome to Bookie!</h3>

        <p>You don't appear to have any bookmarks in Bookie yet.</p>
        <p>
            <span aria-hidden="true" class="icon icon-share" title="import your bookmarks"></span>
            <em class="icon">import your bookmarks</em>
            You can import your bookmarks from Delicious or Google Bookmarks by going to
            the <a href="/{{username}}/import">import page</a>.
        </p>

        <p>
        <img src="/static/images/logo.128.svg" style="height: 32px; padding: 0
        5px;" alt="Google Chrome Extension"/> You might want to get a hold of the <a
        href="https://chrome.google.com/webstore/detail/knnbmilfpmbmlglpeemajjkelcbaaega">extension
        for Google Chrome</a> which will help you save pages to your Bookie
        account.</p>
    </div>
</script>
