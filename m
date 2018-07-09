Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11931 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbeGIMEk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 9 Jul 2018 08:04:40 -0400
Subject: Re: [GIT PULL] RTC for 4.18
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180610221645.GA26123@piout.net>
 <ff6d048a-c683-56e0-13f9-1627cdfd0ea9@nvidia.com>
 <20180626161536.GH4207@piout.net>
 <522c3fc8-a4cc-bd83-d034-b5c690e541d0@nvidia.com>
 <20180626213138.GI4207@piout.net>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7fab97df-9cd9-fa57-47a8-883a717dd96c@nvidia.com>
Date: Mon, 9 Jul 2018 13:04:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180626213138.GI4207@piout.net>
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

On 26/06/18 22:31, Alexandre Belloni wrote:
> On 26/06/2018 17:54:57+0100, Jon Hunter wrote:
>>
>> On 26/06/18 17:15, Alexandre Belloni wrote:
>>> Hi,
>>>
>>> On 26/06/2018 16:51:40+0100, Jon Hunter wrote:
>>>>>       rtc: tps6586x: let the core handle rtc range
>>>>
>>>> Sorry I am missing the original mail with the above change, but I
>>>> have noticed on v4.18-rc1 that rtc wake-ups from suspend are no
>>>> longer working on one of our Tegra boards. The bisect points to the
>>>> above change and reverting it fixes the problem. I have not had
>>>> chance to dig further, but if you have any thoughts, please let me
>>>> know.
>>>
>>>
>>> Thanks for the report, does the following patch fix the issue:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/patch/?id=1b287f23b0a1fcb2b502dae981a8024be379391e
>>
>> Thanks. I gave the above a test, but still not waking-up from suspend.
>>
> 
> Ok, I probably found the issue but the fix is not immediate. I'll try to
> post something tomorrow.

Sorry if I missed it, but did you send a fix for this?

Cheers
Jon

-- 
nvpublic
