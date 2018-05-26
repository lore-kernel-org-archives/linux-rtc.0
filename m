Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:34277 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032377AbeEZVE5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 26 May 2018 17:04:57 -0400
Received: by mail-wr0-f176.google.com with SMTP id j1-v6so14472677wrm.1
        for <linux-rtc@vger.kernel.org>; Sat, 26 May 2018 14:04:57 -0700 (PDT)
Message-ID: <98daac6be2f0200eb672333f1dde59ae6c063987.camel@gmail.com>
Subject: Re: rtc_cmos 00:01: nvmem registration failed
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Date: Sat, 26 May 2018 23:04:54 +0200
In-Reply-To: <20180525093922.GA2500@piout.net>
References: <fa7eee0178fe888859730e7ce41e8e8af512f685.camel@gmail.com>
         <20180525093922.GA2500@piout.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On Fri, 2018-05-25 at 11:39 +0200, Alexandre Belloni wrote:
> > 
> > The "nvmem registration failed" is highlighted red in the journal,
> > and also shows up on every boot.
> > 
> 
> This is probably fixed by
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/co
> mmit/?h=rtc-next&id=c59b3715ac16544f8f68ab7af03f108e339b36aa
> 

Thank you Alexandre!
I can confirm that this patch fixes the issue on my machine.

> > The error message doesn't give any indication about why it failed.
> > How can I help diagnose the what the problem is?
> > 
> 
> My guess is that CONFIG_RTC_NVMEM is not enabled on your kernel.

Yes, that is correct, it isn't enabled.

Best regards,
Tim
