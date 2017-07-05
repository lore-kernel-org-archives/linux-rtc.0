Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:36962 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdGEVUF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 5 Jul 2017 17:20:05 -0400
Date: Wed, 5 Jul 2017 23:19:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Kirill Esipov <yesipov@gmail.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rtc: ds3232: add temperature support
Message-ID: <20170705211953.d6cwqoe24beze2qu@piout.net>
References: <1498649349-4793-1-git-send-email-yesipov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498649349-4793-1-git-send-email-yesipov@gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 28/06/2017 at 14:29:09 +0300, Kirill Esipov wrote:
> DS3232/DS3234 has the temperature registers with a resolution of 0.25
> degree celsius. This enables to get the value through hwmon.
> 
> 	# cat /sys/class/hwmon/hwmon0/temp1_input
> 	37250
> 
> Signed-off-by: Kirill Esipov <yesipov@gmail.com>
> ---
>  drivers/rtc/Kconfig      |   8 ++++
>  drivers/rtc/rtc-ds3232.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 127 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
