<#macro list listData>
<div class="article-list list">
    <ul>
        <#assign articleIds = "">
        <#list listData as article>
        <#assign articleIds = articleIds + article.oId>
        <#if article_has_next><#assign articleIds = articleIds + ","></#if>
        <li>
            <h2>
                <#if 1 == article.articlePerfect>
                <span class="tooltipped tooltipped-w" aria-label="${perfectLabel}"><svg height="20" width="14" viewBox="3 3 11 12">${perfectIcon}</svg></span>
                </#if>
                <#if 1 == article.articleType>
                <span class="tooltipped tooltipped-w" aria-label="${discussionLabel}"><span class="icon-locked"></span></span>
                <#elseif 2 == article.articleType>
                <span class="tooltipped tooltipped-w" aria-label="${cityBroadcastLabel}"><span class="icon-feed"></span></span>
                <#elseif 3 == article.articleType>
                <span class="tooltipped tooltipped-w" aria-label="${thoughtLabel}"><span class="icon-video"></span></span>
                </#if>
                <a data-id="${article.oId}" data-type="${article.articleType}" rel="bookmark" href="${servePath}${article.articlePermalink}">${article.articleTitleEmoj}
                </a>
            </h2>
            <div class="abstract">
                ${article.articlePreviewContent}
            </div>
            <div class="ft-smaller ft-fade fn-clear list-info">
                <span class="author"> 
                    <#if article.articleAnonymous == 0>
                    <a rel="nofollow" 
                       href="${servePath}/member/${article.articleAuthorName}"></#if><div
                       class="avatar-small"
                       style="background-image:url('${article.articleAuthorThumbnailURL48}')"></div><#if article.articleAnonymous == 0></a></#if>&nbsp;
                    <#if article.articleAnonymous == 0>
                    <a rel="nofollow" class="user-name"
                       href="${servePath}/member/${article.articleAuthorName}"></#if>
                       ${article.articleAuthorName}
                    <#if article.articleAnonymous == 0></a></#if>
                    • ${article.timeAgo}
                </span>

                <span class="fn-left">
                    <#list article.articleTagObjs as articleTag>
                    <a rel="tag" class="ft-fade" href="${servePath}/tag/${articleTag.tagURI}">${articleTag.tagTitle}</a> &nbsp; 
                    </#list>
                </span>

                <span class="fn-right">
                    <#if article.articleCommentCount != 0>
                    <a class="ft-fade" href="${servePath}${article.articlePermalink}#comments"><b class="level<#if article.articleCommentCount lt 80>${(article.articleCommentCount/20)?int}<#else>4</#if>">${article.articleCommentCount}</b> ${cmtLabel}</a> &nbsp;•&nbsp;
                    </#if>   

                    <#if article.articleViewCount != 0> 
                    <a class="ft-fade" href="${servePath}${article.articlePermalink}"><span class="level<#if article.articleViewCount lt 800>${(article.articleViewCount/200)?int}<#else>4</#if>">${article.articleViewCount}</span> ${viewLabel}</a>&nbsp;
                    </#if>   

                    <#if "" != article.articleLatestCmterName>
                        •&nbsp; ${article.cmtTimeAgo} 
                        <span class="ft-gray">
                        <#if article.syncWithSymphonyClient>
                            ${article.articleLatestCmterName}
                        <#else>
                            <#if article.articleLatestCmterName != 'someone'>
                            <a rel="nofollow" class="user-name" href="${servePath}/member/${article.articleLatestCmterName}">
                            </#if>
                            ${article.articleLatestCmterName}
                            <#if article.articleLatestCmterName != 'someone'>
                            </a>
                            </#if>
                        </#if> 
                        </span>
                    </#if>
                </span>
            </div>
            
            <span class="heat tooltipped tooltipped-n" aria-label="${postActivityLabel}" style="width:${article.articleHeat*3}px"></span>
        </li>
        </#list>
    </ul>
</div>
</#macro>
<#macro listScript>
<#if articleIds??>
<script type="text/javascript" src="${staticServePath}/js/channel${miniPostfix}.js?${staticResourceVersion}"></script>
<script>
    // Init [Article List] channel
    ArticleListChannel.init("${wsScheme}://${serverHost}:${serverPort}${contextPath}/article-list-channel?articleIds=${articleIds}");
</script>
</#if>
</#macro>