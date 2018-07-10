Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:34098 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933095AbeGJJyI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 10 Jul 2018 05:54:08 -0400
From: Denis OSTERLAND <denis.osterland@diehl.com>
To: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Denis OSTERLAND <denis.osterland@diehl.com>
Subject: [PATCH v4 0/5] rtc: isl1208: fixes, documentation and isl1219 support
Date: Tue, 10 Jul 2018 09:44:15 +0000
Message-ID: <20180710090710.9066-1-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

changes since v3:
Add function to rtc-sysfs to add a group to device groups field,
between alloc and register calls.
Remove isl1208 struct to reduce patch footprint.
Change prefix of defines and functions only available on isl1219.
Use DEVICE_ATTR_RW macro for timestamp0 attribute.
Call validate tm before convert and use unsigned long long cased value.
Add device-tree flag to disable event in pull-up to maximize battery
life time.


Michael Grzeschik (1):
    rtc: isl1208: add support for isl1219 with tamper detection

Denis Osterland (4):
    rtc: sysfs: facilitate attribute add to rtc device
    rtc: isl1208: Add "evdet" interrupt source for isl1219.
    rtc: isl1208: set ev-evienb bit from device tree
    rtc: isl1219: add device tree docu

 .../devicetree/bindings/rtc/isil,isl1219.txt       |  29 ++++
 drivers/rtc/rtc-core.h                             |   6 +
 drivers/rtc/rtc-isl1208.c                          | 181 ++++++++++++++++++---
 drivers/rtc/rtc-sysfs.c                            |  39 +++++
 4 files changed, 232 insertions(+), 23 deletions(-)

Message-Id: 1520246373-19023-1-git-send-email-Denis.Osterland@diehl.com





Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
