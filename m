Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:32836 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdLNDHz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Dec 2017 22:07:55 -0500
Received: by mail-oi0-f42.google.com with SMTP id w131so3029014oiw.0
        for <linux-rtc@vger.kernel.org>; Wed, 13 Dec 2017 19:07:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171213122329.GU8318@piout.net>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
 <20171212221643.GL8318@piout.net> <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
 <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
 <20171213110426.GQ8318@piout.net> <20171213121603.GF6416@sirena.org.uk> <20171213122329.GU8318@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 14 Dec 2017 11:07:54 +0800
Message-ID: <CAMz4kuLZ6yAR+UeZ8qtPLuRoSBg7eqTYvyQYez1qEgeY29=5jA@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 13 December 2017 at 20:23, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 13/12/2017 at 12:16:03 +0000, Mark Brown wrote:
>> On Wed, Dec 13, 2017 at 12:04:26PM +0100, Alexandre Belloni wrote:
>>
>> > Also, I think we could try having only the time64_t in the ring buffer.
>> > Maybe I'm wrong but I think tools reading that buffer can do the
>> > conversion themselves. Maybe I don't understand correctly how
>> > tracepoints work and this doesn't make sense, tell me.
>>
>> Tools reading the buffer can do the conversion themselves but it's also
>> useful for users to just view the log directly via tracing/trace
>> sometimes.  OTOH the whole point is to be low overhead so...
>
> Yes, that is why I suggest keeping both representation in the printk
> but only time64_t in the buffer. And this would be more convenient if we
> add a way to pretty print a time64_t in vsprintf.

OK. I will only keep time64_t in the buffer. Thanks for all your comments.

-- 
Baolin.wang
Best Regards
