Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACCCC388F9
	for <linux-rtc@archiver.kernel.org>; Sat, 21 Nov 2020 23:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DECD217A0
	for <linux-rtc@archiver.kernel.org>; Sat, 21 Nov 2020 23:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCQx8O1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKUXSz (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 21 Nov 2020 18:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKUXSz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 21 Nov 2020 18:18:55 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3A6C0613CF;
        Sat, 21 Nov 2020 15:18:53 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id p12so13954760ljc.9;
        Sat, 21 Nov 2020 15:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PbChZKJWdYhdTrfm1b0qNSHPhxcENieujlsSMgD0+EQ=;
        b=WCQx8O1h5Hs3MqCMtyMcOUXh7qBlrridyDKZIEK7nz3HKedVAH7VA1HEk3jjDz4va0
         ny9qf3cD0sY3Nq579/26BhwE5eixe65o2UBXPFnDpwyNaLheBHVxdWjO4aek3ub8ySyB
         Zb96yElYmIUHlzTQ9fycxXq1GCZJhkU8pAa1CgN23l9heJsNPVqh+3KoErQ0jxKEWrR8
         C3sk/0gN6VMmZrlvPkf1UbqvSf+IDjNOgo8AcfFgPNWHCVwJ5z5NmUvm9IUgvkSzZ4nd
         BJ35Spqk447YNEXTI8vgb2o8B3C7RcxN3Ck5Q0nHqF5xuW8LQXmndUmh4AOMqc23hrhE
         y2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PbChZKJWdYhdTrfm1b0qNSHPhxcENieujlsSMgD0+EQ=;
        b=PswZBd0RKQgJbP/Mg49INJA0Nnxnrvhcmo/zLJz/XsPTar+JWTM3/mx8mQO9UOuzZf
         iahWW9uKxa1DrF8ujTqdy4NEwhZAu/gRZDIouDMCC4otNWJlH5/wsZhhRNWU/3EPqdKB
         gYsWmLwYEnNYiqyMIjbBAYAmSC6EZFLwNscqOcoNjhXjMLemeoJX0mR7zoa+fVKYwYkO
         vM/tJDrJ5c2RQ2K9wcGzBNmsudw23KV2vuPjBGI3jBX7pM+9D0SQXsRBJx3LnT2rl8/C
         hy5GupD8AiayZAbVnQJydsn+hvsEiE1GRThrdx3RMFaqkJRPN4Fy4i4etg9Tjxlb6K/7
         ss4w==
X-Gm-Message-State: AOAM530Lw7G8D9IMqyjgJmyBnySCJ1gjlosBNJmDZTZRnzAesgzeSFCh
        +blMvWK30LWDV6dO10tHlqgGETjizDgX7MWFi/UqqUvj4oQ=
X-Google-Smtp-Source: ABdhPJyVqoNynjs/yL3FwGtZW12XdY4ZrwzlnACNGvN3Dsu2kE/IamkCLke3mtnZ95MQMQO6icI/7clL2UF7YvunwFQ=
X-Received: by 2002:a2e:8682:: with SMTP id l2mr9406140lji.218.1606000731651;
 Sat, 21 Nov 2020 15:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20201121224529.568237-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20201121224529.568237-1-alexandre.belloni@bootlin.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 21 Nov 2020 20:18:39 -0300
Message-ID: <CAOMZO5DKLQ+Y=h_cv4gPmgBz4jkRRsSDVqRshDA7S7zWL0C9Xg@mail.gmail.com>
Subject: Re: [PATCH] rtc: mxc{,_v2}: enable COMPILE_TEST
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sat, Nov 21, 2020 at 7:45 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Extend code coverage for the rtc-mxc and rtc-mxc-v2 drivers.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
