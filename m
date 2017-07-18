Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35552 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbdGRUAJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 18 Jul 2017 16:00:09 -0400
Received: by mail-pg0-f49.google.com with SMTP id v190so18260654pgv.2
        for <linux-rtc@vger.kernel.org>; Tue, 18 Jul 2017 13:00:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] rtc-lib: Add rtc_show_time(const char *prefix_msg)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org,
        a.zummo@towertech.it, linux-rtc@vger.kernel.org
References: <20170718172525.114514-1-salyzyn@android.com>
 <20170718175224.xccqnv4zjggn4shu@piout.net>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <b6bce88c-a13c-8504-18ac-242f637f4d13@android.com>
Date: Tue, 18 Jul 2017 13:00:07 -0700
MIME-Version: 1.0
In-Reply-To: <20170718175224.xccqnv4zjggn4shu@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 07/18/2017 10:52 AM, Alexandre Belloni wrote:
> Hi,
>
> On 18/07/2017 at 10:25:23 -0700, Mark Salyzyn wrote:
>> . . .
> Apart from using rtc_time_to_tm (and you should probably use
> rtc_time64_to_tm), none of this is actually related to the RTC
> subsystem. I feel like you should find another place to put that, maybe
> timekeeping_debug.c?
Makes a lot of sense!

-- Mark
