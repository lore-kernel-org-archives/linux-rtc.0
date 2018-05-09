Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:59934 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935580AbeEIScl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 May 2018 14:32:41 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 90279B002BB
        for <linux-rtc@vger.kernel.org>; Wed,  9 May 2018 20:32:40 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QOWnHDrzsETn for <linux-rtc@vger.kernel.org>;
        Wed,  9 May 2018 20:32:40 +0200 (CEST)
Subject: Re: [PATCH 4/4] rtc: ds1307: add frequency-test property to check
 calibration on m41txx
To: Rob Herring <robh+dt@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180508145611.49072-1-giulio.benetti@micronovasrl.com>
 <20180508145611.49072-4-giulio.benetti@micronovasrl.com>
 <CAL_JsqKb9aLxjQbOc1PFRQhbVL2a3Ti2oJ8Gm8Ojn0a39LxajA@mail.gmail.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <05eb5e80-a38a-1988-bec8-54ba7c6f38df@micronovasrl.com>
Date: Wed, 9 May 2018 20:32:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKb9aLxjQbOc1PFRQhbVL2a3Ti2oJ8Gm8Ojn0a39LxajA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Rob,

Il 08/05/2018 19:44, Rob Herring ha scritto:
> On Tue, May 8, 2018 at 9:56 AM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> On m41txx you can enable open-drain OUT pin to check if calibration is ok.
>> Enabling OUT pin with frequency-test bool property, OUT pin will tick
>> 512 times faster than 1s tick base.
>>
>> Enable FT bit on CONTROL register if calibration is active.
> 
> A DT is (or should be) a pretty static thing, so I don't think this
> belongs. A kernel command line option (via module params) or a
> sysfs/debugfs file would make more sense IMO.

Totally right, it's very useful having it accessible via sysfs.
Already changed and just submitted V2 patchset.
Thanks

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
