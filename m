Return-Path: <SRS0=NKr3=SK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A172C282CE
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 09:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144B620883
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 09:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5Vow9Ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDHJMQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:12:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43887 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHJMQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 8 Apr 2019 05:12:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so10491308lja.10
        for <linux-rtc@vger.kernel.org>; Mon, 08 Apr 2019 02:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIlIGuoA0STjCfoA4Z48qJ4QoJOmXZ7Yk5B9XxZzCHc=;
        b=G5Vow9IedW9AhqhwvB+nznyBfT9427V/u/jHwJHI9Wm8FeAYxE9wLApzoPzgSBIf8E
         xFQwK7g3zWy7JwnwgrwcEOe72/V/cbttdYkRPZBJFvzhZV0QfVkL8cOGmpz37RFLeMPb
         V+rwr9ZbL8oG1dP1BoeqJQyFM1oJx46G9CgfI55BH35aPFd7K9kuPiGUsrZcSz1YqfY9
         KMSJelCAZnjKiruljCd/lLNikhQDBz4QODWlFpi0kchtHQv7SsFGiWRg5wJcyU6/j1V4
         70BqCpy38hqvRuc5Iu7RuV2kLjuwZSptVkJPfsgiy4iLGoxa2z3DxuL9OZdiALSGWjie
         yHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIlIGuoA0STjCfoA4Z48qJ4QoJOmXZ7Yk5B9XxZzCHc=;
        b=omKCS67bvnHBssG5hrDNZPEEf0yN4P2fRD04CUJaBo+FwxjSPYZiShGTjRboVp/5Ms
         jLgao7KMv8cduWu8CzJZEbWnpUvbnsEHoAXepepNEnfhDQ1ub3XyxvaZfiy+8fpz0y0J
         RdzTdUSRDBOJHhYlMFipVUsGey1n+YqWG+Myyt/kEELb9JcGC0kJTmtxeYzefOPn6B/I
         AoFndk/+aiJJqEJWHtka3hInx13d3PPVobad4xLXGZZtTtb7/8LGRsbP7VF2QoptVGPY
         ZiBlRw6ICo+sOzP6cMuRZnnr4e6zNAuj3GZBr45zFH0waR+kNrBOocMz26UUdrrItUdu
         doEA==
X-Gm-Message-State: APjAAAWJLSpSbSyteWCDsBjBkKXKd8USKeZ/EUnlc2UCoGmbpZ3J/9q0
        /rrO7W/fq0mQAbPdyF6Mu4GlD0Vy3uwW0cACwIKF5Q==
X-Google-Smtp-Source: APXvYqylc+otPelJjJ8WSDz8BK5pcLRycr4hKTOGTNri9iNNPvIWJUPBhEAk5TAGmf5sb9pVonBK0x92KsWAyDdkG7E=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr15263523ljb.74.1554714734906;
 Mon, 08 Apr 2019 02:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190407211027.14012-1-alexandre.belloni@bootlin.com> <20190407211027.14012-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20190407211027.14012-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 11:12:03 +0200
Message-ID: <CACRpkda-SC6HX+FC5ZNGDDOhYjH2OxSN52EQRbETT-miEKFbMA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtc: coh901331: use .set_time
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, Apr 7, 2019 at 11:10 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use .set_time instead of the deprecated .set_mmss.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
