Return-Path: <SRS0=dQwf=R6=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A8C43381
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 01:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DF2213A2
	for <linux-rtc@archiver.kernel.org>; Wed, 27 Mar 2019 01:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ek5Myra+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfC0BBK (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:01:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36026 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfC0BBK (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Mar 2019 21:01:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so1314223qtn.3;
        Tue, 26 Mar 2019 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CYNiiTq27LSC7CmrQxd8C5l8JugQDNFvrmLLbjg0BY=;
        b=ek5Myra+P+7avo3KGo29GiTQrn9iTHcMPnbyyPrWWwMzcP/I7RLpiCy7DzInQ6Rgs3
         jG2EAYlwlttbJ22hW5x2S07zMHSlbV/KzvLMsi0Q6AOIzklyCZRZzkjfoWdR7T/TSFC+
         MyEA/Addi1grtOngu/6qLyafzuWLOIvU9haiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CYNiiTq27LSC7CmrQxd8C5l8JugQDNFvrmLLbjg0BY=;
        b=hAxI4wY5zZYp4xxgELxxlDbVY+uHnpv2kygO2SKxL8SOQF7CdeprqiERA8r7KRE3TU
         7Beay0EfZaKdQJl4cnR3UmtfOlzuIIktMGlR2AsZi3djNSaTbCb3W3C+7cAe84cH74B+
         t8JUdvN0fzbZrCm+ecPKuQbkZOYXQ2lV1w3TtsEzkdAw8yYP2JlaxngUOlprVxbp0BBp
         N+m24dClRTF+2NxMSSu+p+oFO1RuXM2JUKyZSIEHv48P9Z1W3GG5wx5TguP6lYHpCKOM
         i1gPmRPB/TYGZOnOr7JXJCsIYa5tXekDEuNX6TvvpUdzlsVCGZvS1FBHCTY+Tvc7VIrI
         6W3Q==
X-Gm-Message-State: APjAAAWC4iYoleCRKjs0eC8Ib4tKhP08/ojYuKZn2CClKM6LDlEag3s4
        439hCIz8laJ5SzcFtTfcqCT6LCiMVsKOOy2SIaCfDg==
X-Google-Smtp-Source: APXvYqxXr51L2F0+NOWbsTEL9c/otLHChqmS0PMLpIek6dAcDjLKD3idnT4OpFspsu55i9UkiR8ZvsBYPaQIs5shccY=
X-Received: by 2002:ac8:26e7:: with SMTP id 36mr28781689qtp.37.1553648469211;
 Tue, 26 Mar 2019 18:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190325133159.10653-1-joel@jms.id.au> <20190325133159.10653-3-joel@jms.id.au>
 <20190325145954.GM30105@piout.net> <CACPK8XfFTF2hDzwO33gE=fotEEC-CZztThoaYj98Le9JAsAQ-w@mail.gmail.com>
 <20190325161010.GP30105@piout.net>
In-Reply-To: <20190325161010.GP30105@piout.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 27 Mar 2019 01:00:56 +0000
Message-ID: <CACPK8Xe0h2iVbuXApccrZD8Qxo4QEpe5Y4OgW1i7GsPfmJKbvQ@mail.gmail.com>
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

On Mon, 25 Mar 2019 at 16:10, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:> >
> While doing that change, I relaized that the whole locking is probably
> unnecessary as all the rtc_ops are called with the rtc lock taken. If
> you are not planning to add alarm support, the lock can be removed.

I had a stab at alarm support, but the select() tests in rtctest.c
were failing. I will submit a v3 without the locking so we can get
that out of the way, and defer adding alarm support for now.

Cheers,

Joel
