Return-Path: <SRS0=lHNh=PE=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0950FC43387
	for <linux-rtc@archiver.kernel.org>; Thu, 27 Dec 2018 09:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BF92148E
	for <linux-rtc@archiver.kernel.org>; Thu, 27 Dec 2018 09:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlD7pH47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbeL0Jnm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 27 Dec 2018 04:43:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46743 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeL0Jnm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 27 Dec 2018 04:43:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so15784971ljh.13
        for <linux-rtc@vger.kernel.org>; Thu, 27 Dec 2018 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ft+oPhdhSv3FR2GIvMb+uWaKkRRWCfgxjkoYM+jDTHU=;
        b=DlD7pH47wSvQDgEQXAJI00aCiOzF7JZO5u36HnvpoXWeJwXddfamL8nkLz1Qh7RxBP
         xgcKjLdRZra2oZEUEoF6MAs/1UKrGgE8/E5BVNWfxLUkh+2p4GjMa/O2KmNrUPdL0jql
         zeP1Dch7bgDYzJhK+d3nwkeV5SZXsQcIC+eNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ft+oPhdhSv3FR2GIvMb+uWaKkRRWCfgxjkoYM+jDTHU=;
        b=BXCmCrzZfZg5S7UDRGWmtWNoG6vRMcp3VYook/3qigU0CESKurgK5wk0g+yYu+z3Mw
         BNaPPsf5Pn/UUwDuCBREU3NszjPivYhy9oA/70ub+NC5wzsWPLxDMSNt0MJrd0/fQngH
         RlH/300dZYQZ1goH1aca9WxH8pH/IXUXlmQSPaIfhWzZQfWN76HHc9/8D4LpDF16r2og
         RQW3Hd/qLowN82+kMmQKxz3zrnGeXHTbNKzikOmk+UupVzAmCwC9iyfRIzXC9M6ekcxy
         5d5L9TmyXRlgiDrrEEatMYnq+oelclVxNQ0KpQZcSX7/rmjwPbQyBdL4Zi2Bugh8M12t
         gt3Q==
X-Gm-Message-State: AJcUukdhkSzAL6QAZ+hNPlfdhbixQMXJgVgTJzutkXLTI81JOah5cnzK
        P8c+FRUA4A0mwLQGwI7UjIi7Zz9UzXkxEdnsVZ+iiliW8P4=
X-Google-Smtp-Source: ALg8bN4AaiiRY0EtKBRNIFxYKF8TkcZwCTQwSQQMaTrAvzFGItE4nKgNeXW6cH24iYCyA7IT5/LCNd9SWQgKaC4G6J0=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr8447228ljj.120.1545903820308;
 Thu, 27 Dec 2018 01:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20181226024333.72236-1-kjlu@umn.edu>
In-Reply-To: <20181226024333.72236-1-kjlu@umn.edu>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Dec 2018 10:43:28 +0100
Message-ID: <CACRpkdacqJAuQoCad8L=k_R_Vz-WAc29J9DdV-7jbJDrb5ET=Q@mail.gmail.com>
Subject: Re: [PATCH] rtc: fix a missing check of clk_prepare
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, Dec 26, 2018 at 3:44 AM Kangjie Lu <kjlu@umn.edu> wrote:

> clk_prepare() could fail, so let's check its status and if it fails
> return its error code upstream.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
