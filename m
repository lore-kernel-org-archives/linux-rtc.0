Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.212.47.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528450;
	b=hvV4gmcbhfVfXmpAtH0BM4VHw63GuOJZ2dJjw93eW2wNEG7atwVckshQAngaYHXrOPkm
	 3nZ/TbhJBuI6r3VX84dFv+bCmdIGQLDyjthreZdW45Y2M8qqvgjAD7I2Ml74BgVyqyb8t
	 Yd0M7HsxjvZpN7s5aYuk6b2j7JakwEpI6ws+NvKTNhaHA6LCFRdSVs1vMSztoRAEHVJFP
	 7l3rnl0LD9W1TUU2qROplxKWu4XlNH/ORuvD0lS6smK+P4yBxEvL6a7x+m11KFIt/Xs+P
	 wDflfyzTE/FGblDPyddnTYRMDPIwJ7E3CuLmZ4AaVbFxVsuotLVkm+BLwnTYu135Gfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528450;
	h=DMARC-Filter:Received:DKIM-Filter:To:From:X-Ip:X-Ip-source:
	 Precedence:List-Unsubscribe:List-Unsubscribe-Post:Subject:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-MagazineId:
	 X-uId:X-Sender:X-Url:Message-Id:Date;
	bh=NOfNgTyd0uEr6RzFm0WGakXbVq4eVhUqaBjZ/gzkpPY=;
	b=DX7xvJY/tEW2DZ2pVQqZgHzpkJnJIZ4aauRBm4CZabycuhDm/YU3ZbJliAcglzLOXwtw
	 rcmfSJb+cadtwLimyLqzXYavRTbxAEM9u2tnCcLwgRo0rEw8V9KLAUPgGfLZSqeKBtKiS
	 0PBCApPPtVWLud33IFHyYTv2tiQlHYBr6gF/zyfXhDaV27ooKOpRCN3FE43z0VlWUXthH
	 h+s86yC3oR+UJlq/Q+11Ap5k8ahWdWB8K6ERz38BKq9WbWivwNwU6vT3HdFj5u3/BRfuy
	 5PIWYT3x+8xrx9+qWgAp1qccqV5dLMlWmMg9FAqQlKW2Q2kQczCFjTKHKKv4tGq/vzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=knowledgelink-corp.jp;
	spf=pass smtp.mailfrom=magerr.combzmail.jp;
	arc=none smtp.remote-ip=49.212.47.36
Received: from r9114.ps.combzmail.jp (r9114.ps.combzmail.jp [49.212.47.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34902606A327
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 00:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34902606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knowledgelink-corp.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9114.ps.combzmail.jp (Postfix, from userid 99)
	id 2B95A3067CD; Fri, 13 Nov 2026 09:04:51 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9114.ps.combzmail.jp 2B95A3067CD
To: linux-rtc@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCP0BFRCFDMGxITDxSQ0RLIT9NJUolbCVDJTglaiVzJS8bKEI=?= <info@knowledgelink-corp.jp>
X-Ip: 8118062929242806
X-Ip-source: k85gj72848dnsad1u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCPFJEOSROMnE8UiROIVYlKCE8JTkhVyEiGyhC?=
 =?ISO-2022-JP?B?GyRCJCQkRDwtJGEkXiQ5JCshKSFaN1AxRDxUOEJEaiU7GyhC?=
 =?ISO-2022-JP?B?GyRCJV8lSiE8IVsbKEI=?=
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 28d1
X-uId: 6764325137486067654956401021
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20261113000603.2B95A3067CD@r9114.ps.combzmail.jp>
Date: Fri, 13 Nov 2026 09:04:51 +0900 (JST)

　
　ルールを決めたら、社員は辞めるどころか
　「迷わなく」なった。
　
　これまでに4,800社以上への支援から分かった
　
　“凡人”を常勝集団に変える
　ルールのつくり方を
　
　次の朝礼から実践できる形で
　分かりやすく丁寧にお伝えします。

┏… Overview …………………………………………┓
　
　「あいつが辞めたら、うちは回るのか？」
　
　　エースに頼らず“凡人”を
　　常勝集団に変えるルールのつくり方

　　　　　　　　―――
　　日　時　11月24日（火）13:00-15:00
　
　　会　場　Zoom無料開催／定員100名
　　事務局　ナレッジリンクセミナー窓口
　
　　詳細はこちら
　　https://knowledge-co.jp/rule/

┗……………………………………………………………┛
　
　
　多くの社長とお話しする中で
　このようなお悩みをよく伺います。
　
　　・エースが辞めたら、売上が大きく落ちる
　　・朝礼に遅れてくる社員がいても、誰も何も言わない
　　・同じミスに、毎回説教。その後、自己嫌悪になる

　研修も、クレドも、評価制度も試した。
　それでも改善は続かず「結局は人次第なのか」と感じている。
　
　
　そんなお悩みを解決し、成果を生み出す会社に一変させる
　本質をついた、ルールづくりをお伝えします。

　
― セミナーで得られること ―

　・ルールを増やすと社員は辞めるのか？への答え
　・「姿勢のルール」の決め方
　・「完全結果」の指示に書き換える方法
　・エラー時に上司がかける「一言」
　
　
　いずれも、翌日の朝礼から試していただける内容です。
　
　自社の組織に希望を持つための気づきを得られる
　内容となっておりますので、ぜひご視聴ください。　
　
　
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

　一般社団法人ナレッジリンク
　東京都千代田区神田小川町1-8-3
　セミナー窓口：03-5256-7638

……………………………………………………………………
　メール案内が不要な方にはご迷惑をお掛けしまして
　大変申し訳ございません。
　お手数ですが下記URLより手続きをお願い致します。
　
　配信の解除依頼はこちら
　https://fc-knowledgelink-corp.jp/mail/

_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
