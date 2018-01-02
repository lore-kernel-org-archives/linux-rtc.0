Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38995 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbeABI04 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Jan 2018 03:26:56 -0500
Received: by mail-oi0-f65.google.com with SMTP id r63so32893349oia.6
        for <linux-rtc@vger.kernel.org>; Tue, 02 Jan 2018 00:26:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102074703.GA3114@piout.net>
References: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
 <20180102074703.GA3114@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 2 Jan 2018 16:26:54 +0800
Message-ID: <CAMz4kuL3xX5v4aYOLY0Fx=U5jny4B2+Fgbv_iJUs5iKrZtR5pw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] rtc: Introduce one interface to save the RTC
 hardware time range
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Jon Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

On 2 January 2018 at 15:47, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi Baolin,
>
> Could you have a look at
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-ranges
>
> My approach has multiple advantages as it works for 64-bit counters and
> the range can be updated at runtime.

Ah, I missed your approach. I will look at it. Thanks.

-- 
Baolin.wang
Best Regards
