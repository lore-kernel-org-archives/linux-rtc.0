Return-Path: <SRS0=i680=R4=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B4DC43381
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 15:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC84920811
	for <linux-rtc@archiver.kernel.org>; Mon, 25 Mar 2019 15:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nuc5ieFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCYP2k (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:28:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40653 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCYP2k (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 25 Mar 2019 11:28:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so5551751qka.7;
        Mon, 25 Mar 2019 08:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeiQMIQzmV9YNgQLFvTaFrVXnctxXB0fdUThXeh0Ml0=;
        b=nuc5ieFr8kjfEPdJvI+TWlpLfIiHJG7vwEOdj/5n7f4Y7xpgPQ0I7nEsu4PsEK4U27
         xTbgGEPjTB3B9VPHAwgDI6SK7ngShXTLPGK9jtaKGnEKQ3aunqmMV5wm1pFV3bqJCVN2
         QYaaIgqmT/VtU5aGC81aWfPvfttMNTPbKQ128=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeiQMIQzmV9YNgQLFvTaFrVXnctxXB0fdUThXeh0Ml0=;
        b=RVUcSBe8IFhB3b75dWY1Mpv26annINaLYWgt1tLjYp7/NaPZVqpQSNZ0TnKMJ/szek
         qDijYsmivW/kizsvOvuH2Uu9zsd9BgpKJgKrY6lC8bh4KG2HjHA15Gj/2KStjIslLUhB
         JlHsSUMah0Xc9/v8UHhm/2EAfqdKLvFQfZTeWjxoOoLrj+/btZfQBq5aIq36tJrnJUrU
         G+g0Q9umdcMp1fNuOXsIWV7wNNMUAm0Sq6D9NnVZvNVxdXaPLkD7yvUk+pkHusalIc8N
         B7Jryi/1NwgmgKYkwBGgOVwsuQAzO/EtMdttb8NWxpRZrrpX50WJderY3gqDsjhNQ7c5
         /eNQ==
X-Gm-Message-State: APjAAAVTtXTwJYOdZjtKuVquCQfwmACwVPzU7ZJwQ/GFvLodulKHotvb
        nDKgl+UFT2AY/SqYSdzyTYlizHOgNyZTkpj0OJk=
X-Google-Smtp-Source: APXvYqzZr3xxgEl1EmaGKtEudVhgXM4D++WMVO6hValyNOKZpqeAVhL4pFQkqCpfQ1AtjuaGo9ciyMkrYQ1w6ia4K3w=
X-Received: by 2002:a37:624e:: with SMTP id w75mr19043381qkb.11.1553527719034;
 Mon, 25 Mar 2019 08:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190325133159.10653-1-joel@jms.id.au> <20190325133159.10653-3-joel@jms.id.au>
 <20190325145954.GM30105@piout.net>
In-Reply-To: <20190325145954.GM30105@piout.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 25 Mar 2019 15:28:26 +0000
Message-ID: <CACPK8XfFTF2hDzwO33gE=fotEEC-CZztThoaYj98Le9JAsAQ-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rtc: Add ASPEED RTC driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-rtc@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 25 Mar 2019 at 14:59, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hi,
>
> This seems mostly good to me.
>
> On 26/03/2019 00:01:59+1030, Joel Stanley wrote:
> > +     dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
> > +                     1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> > +                     tm->tm_hour, tm->tm_min, tm->tm_sec);
> > +
>
> We now have %ptR, could you use that?

I tried this:

  dev_dbg(dev, "%s: %ptR", __func__, tm);

Yes, that appears to do the job. Can you make the change when applying?

>
> > +     rtc->rtc_dev->ops = &aspeed_rtc_ops;
> > +     rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
> > +     rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
> > +
>
> I'm curious how many RTC have been properly designed, could you run
> rtc-range?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-range.c

It appears to pass the test:

Testing 2000-02-28 23:59:59.
OK

Testing 2038-01-19 03:14:07.
OK

Testing 2069-12-31 23:59:59.
OK

Testing 2099-12-31 23:59:59.
OK

Testing 2100-02-28 23:59:59.
OK

Testing 2106-02-07 06:28:15.
OK

Testing 2262-04-11 23:47:16.
OK

The qemu model I have for the device failed though. A good test! Are
you going to put it in the kernel tree?

Cheers,

Joel
