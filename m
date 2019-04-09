Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A966AC10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765A720830
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 11:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CinupDIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfDILuZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:50:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55214 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDILuZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Apr 2019 07:50:25 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39Bmr98167319;
        Tue, 9 Apr 2019 11:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=AIKkuyFALL3plsd3f23RV46nUajtgSPTHayB+FI+bWI=;
 b=CinupDIWvQQdOce8wlHbsTOlZRYEtkzDSQKWqwxlL3Rure4Kh0G0/qktDoIMrU+5WXtY
 rsG/sTgSJDukRV3XY3HL81XqP6uvHPjqg/RvDFAUxi+92nGYPxXZI+jyVysqRr2p8KLc
 ncDRX17ci78pDEKMTWLeQKNlwg/MnH3mxQGC5X1QvgKrSo2kSBCAh/DJV/cmZzixMDhN
 i2s7saFjJQc9ODqPz4QmIqGdoliQxPHdS0DueYipCR4nIOmSVZrSPEMDTR1ZZZXAZxvR
 Yo7/e+M6wYmnLLrStLr5Nil3AXa0HZhXKSAi1D7J5myeii4tSWp4kwbY2XXH964kp6ka xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphmeck19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 11:49:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x39Blq6O167898;
        Tue, 9 Apr 2019 11:49:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2rpkej7tum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 11:49:21 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x39BnKSU023948;
        Tue, 9 Apr 2019 11:49:21 GMT
Received: from kadam (/197.157.0.24)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 04:49:20 -0700
Date:   Tue, 9 Apr 2019 14:49:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     linux-rtc@vger.kernel.org
Subject: [bug report] rtc: rx8025: Switch to use %ptR
Message-ID: <20190409114911.GA16122@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=883
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090076
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=905 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090077
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello Andy Shevchenko,

The patch 1921cab11723: "rtc: rx8025: Switch to use %ptR" from Dec 4,
2018, leads to the following static checker warning:

	drivers/rtc/rtc-rx8025.c:314 rx8025_read_alarm()
	error: '%ptR' expects argument of type struct 'rtc_time', argument 5 has type 'struct rtc_wkalrm*'

drivers/rtc/rtc-rx8025.c
    284 static int rx8025_read_alarm(struct device *dev, struct rtc_wkalrm *t)
                                                         ^^^^^^^^^^^^^^^^^^^^

    285 {
    286 	struct rx8025_data *rx8025 = dev_get_drvdata(dev);
    287 	struct i2c_client *client = rx8025->client;
    288 	u8 ald[2];
    289 	int ctrl2, err;
    290 
    291 	if (client->irq <= 0)
    292 		return -EINVAL;
    293 
    294 	err = rx8025_read_regs(client, RX8025_REG_ALDMIN, 2, ald);
    295 	if (err)
    296 		return err;
    297 
    298 	ctrl2 = rx8025_read_reg(client, RX8025_REG_CTRL2);
    299 	if (ctrl2 < 0)
    300 		return ctrl2;
    301 
    302 	dev_dbg(dev, "%s: read alarm 0x%02x 0x%02x ctrl2 %02x\n",
    303 		__func__, ald[0], ald[1], ctrl2);
    304 
    305 	/* Hardware alarms precision is 1 minute! */
    306 	t->time.tm_sec = 0;
    307 	t->time.tm_min = bcd2bin(ald[0] & 0x7f);
    308 	if (rx8025->ctrl1 & RX8025_BIT_CTRL1_1224)
    309 		t->time.tm_hour = bcd2bin(ald[1] & 0x3f);
    310 	else
    311 		t->time.tm_hour = bcd2bin(ald[1] & 0x1f) % 12
    312 			+ (ald[1] & 0x20 ? 12 : 0);
    313 
--> 314 	dev_dbg(dev, "%s: date: %ptRr\n", __func__, t);
                                        ^^^^^               ^
You mean t->time?

    315 	t->enabled = !!(rx8025->ctrl1 & RX8025_BIT_CTRL1_DALE);
    316 	t->pending = (ctrl2 & RX8025_BIT_CTRL2_DAFG) && t->enabled;
    317 
    318 	return err;
    319 }

regards,
dan carpenter
