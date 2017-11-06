Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:37476 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdKFHC1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 6 Nov 2017 02:02:27 -0500
Subject: Re: [PATCH] rtc: omap: Support scratch registers
To: Keerthy <j-keerthy@ti.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <linux-rtc@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        Linux OMAP List <linux-omap@vger.kernel.org>
References: <20171031162731.27019-1-alexandre.belloni@free-electrons.com>
 <600fd106-9f79-0f5a-a2fd-e6b067785c17@ti.com>
 <4741d4c7-d6f7-ecdb-1eed-1293175f38d9@ti.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <764e60e1-59a4-1082-4307-9d9742d86562@ti.com>
Date: Mon, 6 Nov 2017 12:32:22 +0530
MIME-Version: 1.0
In-Reply-To: <4741d4c7-d6f7-ecdb-1eed-1293175f38d9@ti.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Monday 06 November 2017 12:29 PM, Keerthy wrote:
> 
> 
> On Monday 06 November 2017 12:25 PM, Sekhar Nori wrote:
>> + linux omap list
>>
>> On Tuesday 31 October 2017 09:57 PM, Alexandre Belloni wrote:
>>> Register an nvmem device to expose the 3 scratch registers (total of 12
>>> bytes) to both userspace and kernel space.
>>>
>>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>
>> Looks good to me.
>>
>> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>>
>> Curious on what you are using these registers for.
> 
> This is in response to this:
> https://patchwork.kernel.org/patch/9684955/

Ah, okay. Makes sense then :)

Regards,
Sekhar
