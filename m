Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:33614 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbeGRKOB (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 06:14:01 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id D6633B00756
        for <linux-rtc@vger.kernel.org>; Wed, 18 Jul 2018 11:36:58 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kp_iqOZChKXx for <linux-rtc@vger.kernel.org>;
        Wed, 18 Jul 2018 11:36:58 +0200 (CEST)
Subject: Re: [PATCH v8 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718092216.91053-1-giulio.benetti@micronovasrl.com>
 <20180718092216.91053-2-giulio.benetti@micronovasrl.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <265d0f74-d1ca-11c3-4157-6c0405ecbcda@micronovasrl.com>
Date: Wed, 18 Jul 2018 11:36:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180718092216.91053-2-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Il 18/07/2018 11:22, Giulio Benetti ha scritto:
> +#define M41TXX_REG_CONTROL	0x07
> +#	define M41TXX_BIT_OUT		BIT(7)
> +#	define M41TXX_BIT_FT		BIT(6)
> +#	define M41TXX_BIT_CALIB_SIGN	BIT(5)
> +#	define M41TXX_M_CALIBRATION	GENMASK(5, 0)

This must be GENMASK(4, 0) to be 0x1f.
I'm going to send last patchset, sorry everyone for the mess.

Giulio
