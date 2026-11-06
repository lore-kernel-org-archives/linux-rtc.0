Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.212.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990068;
	b=3+OlUU/NA2oo6i3BcQF/m8EqjeLJOj5+evruRefusOpy1Wcnnqmi/BHY193hZTAz/CVX
	 UjPyUsO8AK/ihTPw9+LFXYlxNyqh7REMdjcWNcP647lsKYZhbnmOE3paYiY37mKkkLmSv
	 YGMcNU0Cp+zZuw6BXnDAQdEaawAWZY9OLCaA4MLzWg+PSIeFcltWhJ0THSS2XIUbUHyit
	 l/t6xNzj3lzz++XANOP/vDwtFf9h9i1eeqbQs/BVouxBi6qgAiXq16DrOUpEoKB7/1Esr
	 4VWCeCg3fL65NYvPMJYdb71WEStSxIVHee1Z73gX8UzS5r8MmGYV3CfXimObaGlPQCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990068;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Abortive-Whistle:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:DKIM-Signature:
	 X-AuthUser:Received:From:To:Cc:Subject:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Date:X-CM-Envelope:X-CM-Analysis;
	bh=xwy0rr+46abKVO94r4Gb7/Dyo13GvYwU4Nn8qCQ2HmA=;
	b=rYw3FRcY0QghMOsh99vvdNa1yMHUMb45RqN73hm/MyVSG/ypNDZ8pJY7kgCtxfvymLsn
	 B0SD+vF+WKsPx/4pZHtY4J0+I4ePNVoq6f0PpaMWdbrqVy/taKzvRZyO9tMI30RJDfF8K
	 U5we6/GBTaHPAN0V4DeUccB2BTwIB02RoN6LBrs/DvJUutaLvwkhZP1XtaWKDVS02giHH
	 yuRy6joLLTRTL4RyhS6JfoEX7cKxQ+vzuloZAd67LgOO22Owik1wVtf8/9+xvLmzcfSSz
	 LnOKTCezBC5iWeGETG9GZMWTcFIbzRUeqAn2smzvS7IiQct/8D7KIot11JqTW8wIA8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marsrover.mx;
	spf=pass smtp.mailfrom=marsrover.mx;
	dkim=pass header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=hoVrGYRB;
	arc=none smtp.remote-ip=23.83.212.45
Received: from crocodile.elm.relay.mailchannels.net (crocodile.elm.relay.mailchannels.net [23.83.212.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53454606A326;
	Fri,  6 Nov 2026 18:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53454606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marsrover.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marsrover.mx header.i=@marsrover.mx header.a=rsa-sha256 header.s=hostingermail-a header.b=hoVrGYRB
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A418E7225FE;
	Fri, 06 Nov 2026 18:34:26 +0000 (UTC)
Received: from fr-int-smtpout27.hostinger.io (100-99-188-64.trex-nlb.outbound.svc.cluster.local [100.99.188.64])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 40426722FAB;
	Fri, 06 Nov 2026 18:34:24 +0000 (UTC)
X-Sender-Id: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|rodrigo.rea@marsrover.mx
X-MailChannels-Auth-Id: hostingeremail
X-Abortive-Whistle: 46afba274ffcde7f_1793990066329_358400402
X-MC-Loop-Signature: 1793990066329:983237729
X-MC-Ingress-Time: 1793990066329
Received: from fr-int-smtpout27.hostinger.io (fr-int-smtpout27.hostinger.io
 [148.222.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.64 (trex/8.0.2);
	Fri, 06 Nov 2026 18:34:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marsrover.mx;
	s=hostingermail-a; t=1793990062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwy0rr+46abKVO94r4Gb7/Dyo13GvYwU4Nn8qCQ2HmA=;
	b=hoVrGYRBQzVb9c3yjO32aWO1N1NWOnlqEELPEnLJ6wqosETqkMZn/bDNgBV7Vn3Fi2G93y
	PPY9Bj1CsP48by5OT4aY5qlU/M7dVP/QVz2Vz5OtPQrqgagBJSFkQyFGTx+0c4KSPpdMJk
	X2amZARadR1n9vldWmOpxYlhWlqKfbVCClfiGzx5w3qh9HkJZMLIeMhf1B3V7MNl/aRpTL
	jbnX/WMtE5w6LDw7chcyPSWT+3j3wPqASOG3w56RF4aq0FHGyIdGCagPEGMhOKHR5uADX4
	eQoU/cDWDJeabEOvYc9+0y//fkBUFxpzfz1xQxSk97Hnx4OKs34AzWrvqArlow==
X-AuthUser: rodrigo.rea@marsrover.mx
Received: from 0-0.nxp.com (static-148-244-115-92.alestra.net.mx [148.244.115.92])
	(Authenticated sender: rodrigo.rea@marsrover.mx)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jLnrq4MTqz2yqF;
	Fri,  6 Nov 2026 18:34:19 +0000 (UTC)
From: Rodrigo Rea <rodrigo.rea@marsrover.mx>
To: Conor Dooley <conor@kernel.org>
Cc: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alexander.stein@ew.tq-group.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.aguirre@nxp.com,
	rodrigo.rea@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: rtc: pcf85063: Add NXP PCA85074A
Message-ID: <20261106183402.7514-1-rodrigo.rea@marsrover.mx>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106-shush-suffering-cd7caec6e3a2@spud>
References: <20261105215204.2446733-1-rodrigo.rea@marsrover.mx>  <20261105215204.2446733-2-rodrigo.rea@marsrover.mx>  <20261106-shush-suffering-cd7caec6e3a2@spud>
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Fri,  6 Nov 2026 18:34:19 +0000 (UTC)
X-CM-Envelope: MS4xfBU0Y2j4nb8GK7p8964viWbiUsSv4qWqKtKG1qIjt2OJ2thOXq23Je8/jukXdUVeU6SvMKugl66Hee4liLnFAWj88pPKDwbqdNhspNIqlq6oR1ZvTT9v c8xK+kjSmanC05nvuU5jlLzwV79w6EkJxd8PT/2cXtF2n/WT843tIyjlRswd/v7YErJvoTZ0lWRrtH0gs3wxQ3lZf6MSOtklVy8zahZBfsaZ1ouHFU19IMNm gkEJ4KyCyIKO4r3nHArRo7ZoK/7X3hiOi/E6do2naaR9GKO/jPu+mdP1HTCpWDOV3j9uK9vdA08rlrUp8gKZLCxhviunuksQfng/muDV8KyyF1XeY4zdpDbu T4nmnFoCq2re+SAn5+zBhCryOd1xFX5JKxZ7wF/VQ+g+wS4WrDd0jB8DyFA3n6GuSXyrJ4Fk38F9eb/xZso+k1ASQA6zhvsjGCkHZH/C6hUXONYmWoGIAS4T nOuay/2i1yGa3gOMkm+rAgD6+d10f72O4LxN1UfWTX43Ug+9ZOIbzxmD7TLVq5pxpGDAEZEbNHQOEcsL
X-CM-Analysis: v=2.4 cv=CoDtcW4D c=1 sm=1 tr=0 ts=6aee1dae a=VnbrY5TOLAh+WZUOsuTEUw==:117 a=VnbrY5TOLAh+WZUOsuTEUw==:17 a=kj9zAlcOel0A:10 a=dhTltIek3hopVLoF0psA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10

Hi Conor,=0D
=0D
> Driver change suggests a fallback compatible can be used. Why haven't=0D
> you used one?=0D
=0D
I overlooked the fallback approach when adding the new compatible.=0D
I added explicit driver match entries, but they reuse the existing=0D
configuration without any chip-specific changes.=0D
=0D
Thanks for pointing this out. I'll verify the compatibility with=0D
PCA85073A and update the binding to use a fallback in v2 if confirmed.=0D
=0D
Regards,=0D
Rodrigo=0D
