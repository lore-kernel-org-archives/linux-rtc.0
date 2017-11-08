Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43608 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbdKHUB0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 15:01:26 -0500
Received: by mail-ot0-f195.google.com with SMTP id k10so3373404otb.0
        for <linux-rtc@vger.kernel.org>; Wed, 08 Nov 2017 12:01:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108023000.4oepp5pyz32c7sr3@piout.net>
References: <1509730361-23905-1-git-send-email-akshay.bhat@timesys.com>
 <1509730361-23905-3-git-send-email-akshay.bhat@timesys.com> <20171108023000.4oepp5pyz32c7sr3@piout.net>
From: Akshay Bhat <akshay.bhat@timesys.com>
Date: Wed, 8 Nov 2017 15:00:45 -0500
Message-ID: <CACrMeVDtSH1dJaw7Ct8c7WTLgYuA1LdOHHQW3LggsK3E5WaRzw@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: rx8010: Fix for incorrect return value
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Nov 7, 2017 at 9:30 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 03/11/2017 at 13:32:41 -0400, Akshay Bhat wrote:
>>       if (err != 2)
>>               return err < 0 ? err : -EIO;
>> +     err = 0;
>
> Isn't it simpler to make the function return 0 instead of err at the end?

Makes sense, fixed in v2 patch, thanks.
