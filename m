Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:44157 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdJEQqI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 12:46:08 -0400
Received: by mail-qt0-f174.google.com with SMTP id v28so17706616qtv.1
        for <linux-rtc@vger.kernel.org>; Thu, 05 Oct 2017 09:46:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALAqxLUnpNQrduA09V4uAe=3-57UU9g9Qyaqg7PE9RnNjGAVeA@mail.gmail.com>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <alpine.DEB.2.20.1710041931560.2406@nanos> <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com>
 <CALAqxLUnpNQrduA09V4uAe=3-57UU9g9Qyaqg7PE9RnNjGAVeA@mail.gmail.com>
From: Gabriel Beddingfield <gabe@nestlabs.com>
Date: Thu, 5 Oct 2017 09:46:06 -0700
Message-ID: <CAOdF7nt8aOUie_qF7Uryyvo6eOxv3E9KdWL1Ju+afaiDODHOAA@mail.gmail.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
To: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        Howard Harte <hharte@nestlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi John,

First, my apologies for calling it a "hack." I just went back and looked at the
commit history and this is first-class stuff... and you explained it very well
(including the NTP interaction) in the commit message. I'm pretty sure I
read this before, but I reckon most of it went over my head and I garbled it.

On Wed, Oct 4, 2017 at 5:20 PM, John Stultz <john.stultz@linaro.org> wrote:
> Yea. I thought arm devices often had read_persistent_clock64() backed
> by the 32k timer (which is poor for time initialization but works well
> for suspend timing).
>
> Maybe I misunderstood on the first read. Is it then that the
> relatively fine-grained read_persistent_clock64() is colliding with
> the delta_delta logic that assumes we get coarse 1sec resolution? In
> that case the huristic above seems sane.

Yes, exactly.

-gabe
