Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45311 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdKOJZk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 04:25:40 -0500
Date: Wed, 15 Nov 2017 10:25:39 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, rostedt@goodmis.org, mingo@redhat.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, broonie@kernel.org
Subject: Re: [PATCH] rtc: Add tracepoints for RTC system
Message-ID: <20171115092539.xrenngsxvsxzizs3@piout.net>
References: <354301cc7c61ba39021bb56e7ede5ba959e9dbb2.1510730564.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <354301cc7c61ba39021bb56e7ede5ba959e9dbb2.1510730564.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 15/11/2017 at 15:30:21 +0800, Baolin Wang wrote:
> It will be more helpful to add some tracepoints to track RTC actions when
> debugging RTC driver. Below sample is that we set/read the RTC time, then
> set 2 alarms, so we can see the trace logs:

I'm not sure it is actually useful when debugging an RTC driver because
you will be interested in the real values that are written to or read
from the RTC, not what is returned by the driver to the RTC core as this
information is already readily available to userspace.

Is this really worth the added overhead?

Maybe you have another use case?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
